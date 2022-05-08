void getStatsAndModifiers() {

  modifiedStats[0] = coreStats[0] + getStatModifiers("strength-score");
  modifiedStats[1] = coreStats[1] + getStatModifiers("dexterity-score");
  modifiedStats[2] = coreStats[2] + getStatModifiers("constitution-score");
  modifiedStats[3] = coreStats[3] + getStatModifiers("intelligence-score");
  modifiedStats[4] = coreStats[4] + getStatModifiers("wisdom-score");
  modifiedStats[5] = coreStats[5] + getStatModifiers("charisma-score");

  abilityModifiers[0]  = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("acrobatics")      * proficiencyBonus;
  abilityModifiers[1]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("animal-handling") * proficiencyBonus;
  abilityModifiers[2]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("arcana")          * proficiencyBonus;
  abilityModifiers[3]  = getModifierFromScore(modifiedStats[0]) + getProficiencyModifiers("athletics")       * proficiencyBonus;
  abilityModifiers[4]  = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("deception")       * proficiencyBonus;
  abilityModifiers[5]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("history")         * proficiencyBonus;
  abilityModifiers[6]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("insight")         * proficiencyBonus;
  abilityModifiers[7]  = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("intimidation")    * proficiencyBonus;
  abilityModifiers[8]  = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("investigation")   * proficiencyBonus;
  abilityModifiers[9]  = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("medicine")        * proficiencyBonus;
  abilityModifiers[10] = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("nature")          * proficiencyBonus;
  abilityModifiers[11] = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("perception")      * proficiencyBonus;
  abilityModifiers[12] = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("performance")     * proficiencyBonus;
  abilityModifiers[13] = getModifierFromScore(modifiedStats[5]) + getProficiencyModifiers("persuasion")      * proficiencyBonus;
  abilityModifiers[14] = getModifierFromScore(modifiedStats[3]) + getProficiencyModifiers("religion")        * proficiencyBonus;
  abilityModifiers[15] = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("sleight-of-hand") * proficiencyBonus;
  abilityModifiers[16] = getModifierFromScore(modifiedStats[1]) + getProficiencyModifiers("stealth")         * proficiencyBonus;
  abilityModifiers[17] = getModifierFromScore(modifiedStats[4]) + getProficiencyModifiers("survival")        * proficiencyBonus;

  savingThrowModifiers[0] = getModifierFromScore(modifiedStats[0]) + getSavingThrowProficiencyModifiers("strength") * proficiencyBonus;
  savingThrowModifiers[1] = getModifierFromScore(modifiedStats[1]) + getSavingThrowProficiencyModifiers("dexterity") * proficiencyBonus;
  savingThrowModifiers[2] = getModifierFromScore(modifiedStats[2]) + getSavingThrowProficiencyModifiers("constitution") * proficiencyBonus;
  savingThrowModifiers[3] = getModifierFromScore(modifiedStats[3]) + getSavingThrowProficiencyModifiers("intelligence") * proficiencyBonus;
  savingThrowModifiers[4] = getModifierFromScore(modifiedStats[4]) + getSavingThrowProficiencyModifiers("wisdom") * proficiencyBonus;
  savingThrowModifiers[5] = getModifierFromScore(modifiedStats[5]) + getSavingThrowProficiencyModifiers("charisma") * proficiencyBonus;

  for (int i = 0; i < weaponListLen; i++) {
    if (weapons[i] != null) {
      if (isWeaponFinesse[i]) {
        if ((isWeaponLight[i] == true) && (!isWeaponLightZeroMultiplier[i])) {
          weaponsModifiers[i] = 0;
        } else {
          weaponsModifiers[i] = max(getModifierFromScore(modifiedStats[0]), getModifierFromScore(modifiedStats[1]));
        }
      } else {
        if ((isWeaponLight[i] == true) && (!isWeaponLightZeroMultiplier[i])) {
          weaponsModifiers[i] = 0;
        } else {
          weaponsModifiers[i] = getModifierFromScore(modifiedStats[0]);
        }
      }
    }
  }
}
