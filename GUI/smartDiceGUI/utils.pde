void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
    case "/check1":
      currentRoll = "Acrobatics";
      modifier = abilityModifiers[0];
      break;
    case "/check2":
      currentRoll = "Animal Handling";
      modifier = abilityModifiers[1];
      break;
    case "/check3":
      currentRoll = "Arcana";
      modifier = abilityModifiers[2];
      break;
    case "/check4":
      currentRoll = "Athletics";
      modifier = abilityModifiers[3];
      break;
    case "/check5":
      currentRoll = "Deception";
      modifier = abilityModifiers[4];
      break;
    case "/check6":
      currentRoll = "History";
      modifier = abilityModifiers[5];
      break;
    case "/check7":
      currentRoll = "Insight";
      modifier = abilityModifiers[6];
      break;
    case "/check8":
      currentRoll = "Intimidation";
      modifier = abilityModifiers[7];
      break;
    case "/check9":
      currentRoll = "Investigation";
      modifier = abilityModifiers[8];
      break;
    case "/check10":
      currentRoll = "Medicine";
      modifier = abilityModifiers[9];
      break;
    case "/check11":
      currentRoll = "Nature";
      modifier = abilityModifiers[10];
      break;
    case "/check12":
      currentRoll = "Perception";
      modifier = abilityModifiers[11];
      break;
    case "/check13":
      currentRoll = "Performance";
      modifier = abilityModifiers[12];
      break;
    case "/check14":
      currentRoll = "Persuasion";
      modifier = abilityModifiers[13];
      break;
    case "/check15":
      currentRoll = "Religion";
      modifier = abilityModifiers[14];
      break;
    case "/check16":
      currentRoll = "Sleight of Hand";
      modifier = abilityModifiers[15];
      break;
    case "/check17":
      currentRoll = "Stealth";
      modifier = abilityModifiers[16];
      break;
    case "/check18":
      currentRoll = "Survival";
      modifier = abilityModifiers[17];
      break;
    case "/save1":
      currentRoll = "STR save";
      modifier = savingThrowModifiers[0];
      break;
    case "/save2":
      currentRoll = "DEX save";
      modifier = savingThrowModifiers[1];
      break;
    case "/save3":
      currentRoll = "CON save";
      modifier = savingThrowModifiers[2];
      break;
    case "/save4":
      currentRoll = "INT save";
      modifier = savingThrowModifiers[3];
      break;
    case "/save5":
      currentRoll = "WIS save";
      modifier = savingThrowModifiers[4];
      break;
    case "/save6":
      currentRoll = "CHA save";
      modifier = savingThrowModifiers[5];
      break;
    case "/initiative":
      currentRoll = "Initiative";
      modifier = getModifierFromScore(modifiedStats[1]);
      break;
    case "/attack1":
      currentRoll = weaponName[0];
      modifier = weaponsModifiers[0];
      break;
    case "/attack2":
      currentRoll = weaponName[1];
      modifier = weaponsModifiers[1];
      break;
    case "/attack3":
      currentRoll = weaponName[2];
      modifier = weaponsModifiers[2];
      break;
    case "/attack4":
      currentRoll = weaponName[3];
      modifier = weaponsModifiers[3];
      break;
    case "/attack5":
      currentRoll = weaponName[4];
      modifier = weaponsModifiers[4];
      break;
    case "/attack6":
      currentRoll = weaponName[5];
      modifier = weaponsModifiers[5];
      break;
    case "/attack7":
      currentRoll = weaponName[6];
      modifier = weaponsModifiers[6];
      break;
    case "/attack8":
      currentRoll = weaponName[7];
      modifier = weaponsModifiers[7];
      break;
    case "/attack9":
      currentRoll = weaponName[8];
      modifier = weaponsModifiers[8];
      break;
    case "/attack10":
      currentRoll = weaponName[9];
      modifier = weaponsModifiers[9];
      break;
    case "/attack11":
      currentRoll = weaponName[10];
      modifier = weaponsModifiers[10];
      break;
    case "/attack12":
      currentRoll = weaponName[11];
      modifier = weaponsModifiers[11];
      break;
    case "/attack13":
      currentRoll = weaponName[12];
      modifier = weaponsModifiers[12];
      break;
    case "/attack14":
      currentRoll = weaponName[13];
      modifier = weaponsModifiers[13];
      break;
    case "/attack15":
      currentRoll = weaponName[14];
      modifier = weaponsModifiers[14];
      break;
    case "/attack16":
      currentRoll = weaponName[15];
      modifier = weaponsModifiers[15];
      break;    
    case "/attack17":
      currentRoll = weaponName[16];
      modifier = weaponsModifiers[16];
      break;    
    case "/attack18":
      currentRoll = weaponName[17];
      modifier = weaponsModifiers[17];
      break;
    }
  }
}


void myRead(boolean go) {
  if (go) {
    if ( port.available() > 0) {  // If data is available,
      lineVal = port.readStringUntil('\n'); 
      try {
        tmp = Integer.valueOf(lineVal.trim());
        if (tmp != 0) {
          sensorVal = tmp;
        }
      }
      catch(Exception e) {
        ;
      }
    }
  }
}

int getProficiencyBonus(int lev) {
  if (lev <= 4) {
    return 2;
  } else if (lev <= 8) {
    return 3;
  } else if (lev <= 12) {
    return 4;
  } else if (lev <= 16) {
    return 5;
  } else {
    return 6;
  }
}

int isWeaponProficiency (String _weaponType) {

  for (int k = 0; k < 6; k++) {
    jsonMod = json.getJSONObject("modifiers").getJSONArray(modifierOrigins[k]);
    size_   = jsonMod.size();

    for (int i = 0; i < size_; i++) {
      type    = jsonMod.getJSONObject(i).getString("type");
      subType = jsonMod.getJSONObject(i).getString("subType");
      if (type.equals("proficiency")) {
        if (subType.equals("simple-weapons")) {
          for (int j = 0; j < 14; j++) {
            if (_weaponType.equals(simpleWeapons[j])) {
              return 1;
            }
          }
        } else if (subType.equals("martial-weapons")) {
          for (int j = 0; j < 23; j++) {
            if (_weaponType.equals(martialWeapons[j])) {
              return 1;
            }
          }
        } else {
          if (_weaponType.equals(subType)) {
            return 1;
          }
        }
      }
    }
  }
  return 0;
}


void findEquippedWeapons() {

  size_ = jsonInventory.size();

  for (int i = 0; i < size_; i++) {
    if ((jsonInventory.getJSONObject(i).getBoolean("equipped")) &&
      (jsonInventory.getJSONObject(i).getJSONObject("definition").getString("filterType").equals("Weapon"))) {
      weaponType[numberOfweapons] = jsonInventory.getJSONObject(i).getJSONObject("definition").getString("type");
      size_2 = jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("properties").size();
      for (int j = 0; j < size_2; j++) {
        if (jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("properties").getJSONObject(j).getString("name").equals("Light")) {
          isWeaponLight[numberOfweapons] = true;
        }
        if (jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("properties").getJSONObject(j).getString("name").equals("Finesse")) {
          isWeaponFinesse[numberOfweapons] = true;
        }
      }

      // getting name
      jsonInventoryId = jsonInventory.getJSONObject(i).getInt("id");
      jsonCharacterValues = json.getJSONArray("characterValues");
      int charValSize = jsonCharacterValues.size();
      if (charValSize > 0) {
        for (int k = 0; k < charValSize; k++) {
          if (str(jsonInventoryId).equals(jsonCharacterValues.getJSONObject(k).getString("valueId"))) {
            weaponName[numberOfweapons] = jsonCharacterValues.getJSONObject(k).getString("value");
            break;
          } else {
            weaponName[numberOfweapons] = jsonInventory.getJSONObject(i).getJSONObject("definition").getString("name");
          }
        }
      } else {
        weaponName[numberOfweapons] = jsonInventory.getJSONObject(i).getJSONObject("definition").getString("name");
      }


      // getting bonus from e.g. magic weapons
      int grantedModifierSize = jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("grantedModifiers").size();
      for (int l = 0; l < grantedModifierSize; l++) {
        if (jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(l).getString("subType").equals("magic")) {
          //println(l);
          //print(weaponName[numberOfweapons]);
          //println(jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(l).getInt("fixedValue"));
          //print(numberOfweapons);
          weaponsBonus[numberOfweapons] = jsonInventory.getJSONObject(i).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(l).getInt("fixedValue", 0);
        }
      }

      numberOfweapons++;
    }
  }

  for (int i = 0; i < numberOfweapons; i++) {
    for (int j = i; j < numberOfweapons; j++) {
      if (i != j) {
        if (weaponName[i].equals(weaponName[j])) {
          weaponName[i] = weaponName[i] + " 1";
          weaponName[j] = weaponName[j] + " 2";
        }
      }
    }
  }


  for (int i = 0; i < weaponListLen; i++) {
    isWeaponLightZeroMultiplier[i] = false;
  }
  for (int i = 0; i < weaponListLen; i++) {
    if (isWeaponLight[i] == true) {
      isWeaponLightZeroMultiplier[i] = true;
      break;
    }
  }
}

void findSpells() {
  jsonCharacterValues = json.getJSONArray("characterValues");
  //jsonClassSpells = json.getJSONArray("classSpells");
  int classSpellsSize = json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").size();
  for (int i = 0; i < classSpellsSize; i++) {

    try {
      if (str(json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getJSONObject("definition").getInt("attackType")).equals("1") ||
        str(json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getJSONObject("definition").getInt("attackType")).equals("2")) {
        //println(json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getJSONObject("definition").getString("name"));

        jsonSpellId = json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getInt("id");
        jsonCharacterValues = json.getJSONArray("characterValues");
        int charValSize = jsonCharacterValues.size();


        weaponName[numberOfweapons + numberOfSpells] = json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getJSONObject("definition").getString("name");
        for (int k = 0; k < charValSize; k++) {
          //println(weaponName[numberOfweapons + numberOfSpells] = json.getJSONArray("classSpells").getJSONObject(0).getJSONArray("spells").getJSONObject(i).getJSONObject("definition").getString("name"));
          if (str(jsonSpellId).equals(jsonCharacterValues.getJSONObject(k).getString("valueId"))) {
            weaponName[numberOfweapons + numberOfSpells] = jsonCharacterValues.getJSONObject(k).getString("value");
            break;
          }
        }


        // get bonus modifier from inventory
        size_ = jsonInventory.size();
        for (int j = 0; j < size_; j++) {
          if (jsonInventory.getJSONObject(j).getBoolean("equipped")) {
            int gmSize = jsonInventory.getJSONObject(j).getJSONObject("definition").getJSONArray("grantedModifiers").size();
            for (int g = 0; g < gmSize; g++) {
              if (jsonInventory.getJSONObject(j).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(g).getString("type").equals("bonus") &&
                jsonInventory.getJSONObject(j).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(g).getString("subType").equals("spell-attacks")) {
                weaponsBonus[numberOfweapons + numberOfSpells] += jsonInventory.getJSONObject(j).getJSONObject("definition").getJSONArray("grantedModifiers").getJSONObject(g).getInt("fixedValue", 0);
              }
            }
          }
        }


        numberOfSpells++;
      }
    }
    catch(Exception e) {
      ;
    }
  }
}


int getSavingThrowProficiencyModifiers(String skill) {

  int proficiencyMultiplier = 0;

  for (int k = 0; k < 6; k++) {
    jsonMod = json.getJSONObject("modifiers").getJSONArray(modifierOrigins[k]);
    size_ = jsonMod.size();
    for (int i = 0; i < size_; i++) {
      type = jsonMod.getJSONObject(i).getString("type");
      subType = jsonMod.getJSONObject(i).getString("subType");
      if ((type.equals("proficiency")) && (subType.equals(skill + "-saving-throws"))) {
        proficiencyMultiplier = 1;
        break;
      }
    }
  }
  return proficiencyMultiplier;
}

int getProficiencyModifiers(String skill) {

  int proficiencyMultiplier = 0;

  for (int k = 0; k < 6; k++) {
    jsonMod = json.getJSONObject("modifiers").getJSONArray(modifierOrigins[k]);
    size_ = jsonMod.size();
    for (int i = 0; i < size_; i++) {
      type = jsonMod.getJSONObject(i).getString("type");
      subType = jsonMod.getJSONObject(i).getString("subType");
      if ((type.equals("proficiency")) && (subType.equals(skill))) {
        proficiencyMultiplier = 1;
      } else if ((type.equals("expertise")) && (subType.equals(skill))) {
        proficiencyMultiplier = 2;
        break;
      }
    }
  }
  return proficiencyMultiplier;
}

int getStatModifiers(String skill) {

  int modValueTmp = 0;

  for (int k = 0; k < 6; k++) {
    jsonMod = json.getJSONObject("modifiers").getJSONArray(modifierOrigins[k]);
    size_ = jsonMod.size();
    for (int i = 0; i < size_; i++) {
      type = jsonMod.getJSONObject(i).getString("type");
      subType = jsonMod.getJSONObject(i).getString("subType");
      if ((type.equals("bonus")) && (subType.equals(skill))) {
        modValueTmp = modValueTmp + jsonMod.getJSONObject(i).getInt("fixedValue");
      }
    }
  }
  return modValueTmp;
}

int getModifierFromScore(int score) {
  return floor((score - 10) / 2);
}
