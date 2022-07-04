#!/usr/bin/env python3# -*- coding: utf-8 -*-"""Created on Mon Jul  4 22:25:57 2022@author: thorknudsen"""import requestsimport numpy as npclass Character:        def __init__(self, ID):        self.data = requests.get("https://character-service.dndbeyond.com/character/v3/character/" + str(ID)).json().get("data")        self.getName()        self.getLevel()        self.getClass()        self.getRace()        self.getProficiencyBonus()        self.getCoreStats()        self.getStat()        self.getStatModifiers()        self.getInitiative()        self.getSavingThrowMultipliers()        self.getAbilityModifers()        def getName(self):        self.name = self.data.get("name")        def getLevel(self):        """        This does not support multiclassing.        Only the first entry of the classes list is used but I presume that        multiclassing would results in multiple entries, possibly resulting in        the total level being the sum of the individual levels.        """        self.level = self.data.get("classes")[0].get("level")            def getClass(self):        """        This does not support multiclassing.        """        self.Class = self.data.get("classes")[0].get("definition").get("name")            def getRace(self):        self.race = self.data.get("race").get("baseName")        def getProficiencyBonus(self):        # if self.level <= 4:        #     self.proficiencyBonus = 2        # elif self.level <= 8:        #     self.proficiencyBonus = 3        # elif self.level <= 12:        #     self.proficiencyBonus = 4        # elif self.level <= 16:        #     self.proficiencyBonus = 5        # else:        #     self.proficiencyBonus = 6        self.proficiencyBonus = ((self.level - 1) // 4) + 2    def getCoreStats(self):        stats = np.zeros(6, dtype=np.int8)        for stat in range(stats.shape[0]):            stats[stat] = self.data.get("stats")[stat].get("value")        self.coreStats = stats            def getStat(self):        modifiers = np.zeros(6, dtype=np.int8)        for idxS, stat in enumerate(["strength-score", "dexterity-score", "constitution-score", "intelligence-score", "wisdom-score", "charisma-score"]):            for origin in ["race", "class", "background", "item", "feat", "condition"]:                mods = self.data.get("modifiers").get(origin)                for mod in mods:                    if (mod.get("type") == "bonus") and (mod.get("subType") == stat):                        modifiers[idxS] += mod.get("fixedValue")                self.stats = self.coreStats + modifiers        def getStatModifiers(self):        self.statsModifiers = self.getModifierFromScore(self.stats)        def getInitiative(self):        self.initiative = self.getModifierFromScore(self.stats[1])        def getSavingThrowMultipliers(self):        proficiencyModifiers = np.zeros(6, dtype=bool)        for idxS, stat in enumerate(["strength", "dexterity", "constitution", "intelligence", "wisdom", "charisma"]):            for origin in ["race", "class", "background", "item", "feat", "condition"]:                mods = self.data.get("modifiers").get(origin)                for mod in mods:                    if (mod.get("type") == "proficiency") and (mod.get("subType") == (stat + "-saving-throws")):                        proficiencyModifiers[idxS] = True                        break                self.savingThrowMultipliers = self.statsModifiers + (proficiencyModifiers * self.proficiencyBonus)        def getAbilityModifers(self):        abilityModifiers = np.zeros(18, dtype=np.int8)                abilityModifiers[0]  = self.statsModifiers[1] + (self.getProficiencyExpertiseAbility("acrobatics")      * self.proficiencyBonus)        abilityModifiers[1]  = self.statsModifiers[4] + (self.getProficiencyExpertiseAbility("animal-handling") * self.proficiencyBonus)        abilityModifiers[2]  = self.statsModifiers[3] + (self.getProficiencyExpertiseAbility("arcana")          * self.proficiencyBonus)        abilityModifiers[3]  = self.statsModifiers[0] + (self.getProficiencyExpertiseAbility("athletics")       * self.proficiencyBonus)        abilityModifiers[4]  = self.statsModifiers[5] + (self.getProficiencyExpertiseAbility("deception")       * self.proficiencyBonus)        abilityModifiers[5]  = self.statsModifiers[3] + (self.getProficiencyExpertiseAbility("history")         * self.proficiencyBonus)        abilityModifiers[6]  = self.statsModifiers[4] + (self.getProficiencyExpertiseAbility("insight")         * self.proficiencyBonus)        abilityModifiers[7]  = self.statsModifiers[5] + (self.getProficiencyExpertiseAbility("intimidation")    * self.proficiencyBonus)        abilityModifiers[8]  = self.statsModifiers[3] + (self.getProficiencyExpertiseAbility("investigation")   * self.proficiencyBonus)        abilityModifiers[9]  = self.statsModifiers[4] + (self.getProficiencyExpertiseAbility("medicine")        * self.proficiencyBonus)        abilityModifiers[10] = self.statsModifiers[3] + (self.getProficiencyExpertiseAbility("nature")          * self.proficiencyBonus)        abilityModifiers[11] = self.statsModifiers[4] + (self.getProficiencyExpertiseAbility("perception")      * self.proficiencyBonus)        abilityModifiers[12] = self.statsModifiers[5] + (self.getProficiencyExpertiseAbility("performance")     * self.proficiencyBonus)        abilityModifiers[13] = self.statsModifiers[5] + (self.getProficiencyExpertiseAbility("persuasion")      * self.proficiencyBonus)        abilityModifiers[14] = self.statsModifiers[3] + (self.getProficiencyExpertiseAbility("religion")        * self.proficiencyBonus)        abilityModifiers[15] = self.statsModifiers[1] + (self.getProficiencyExpertiseAbility("sleight-of-hand") * self.proficiencyBonus)        abilityModifiers[16] = self.statsModifiers[1] + (self.getProficiencyExpertiseAbility("stealth")         * self.proficiencyBonus)        abilityModifiers[17] = self.statsModifiers[4] + (self.getProficiencyExpertiseAbility("survival")        * self.proficiencyBonus)                    self.abilityModifiers = abilityModifiers        def getProficiencyExpertiseAbility(self, ability):        proficiencyMultiplier = 0        for origin in ["race", "class", "background", "item", "feat", "condition"]:            mods = self.data.get("modifiers").get(origin)            for mod in mods:                if (mod.get("type") == "proficiency") and (mod.get("subType") == ability):                    proficiencyMultiplier = 1                elif (mod.get("type") == "expertise") and (mod.get("subType") == ability):                    return 2        return proficiencyMultiplier        def getModifierFromScore(self, score):        return (score - 10) // 2