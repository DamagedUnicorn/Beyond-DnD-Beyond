void getJSONData() {

  json          = loadJSONObject(dndUrl + str(characterId)).getJSONObject("data");
  jsonStats     = json.getJSONArray("stats");
  jsonClasses   = json.getJSONArray("classes");
  jsonInventory = json.getJSONArray("inventory");

  characterClass = jsonClasses.getJSONObject(0).getJSONObject("definition").getString("name");
  level = jsonClasses.getJSONObject(0).getInt("level");
  proficiencyBonus = getProficiencyBonus(level);
  name = json.getString("name");

  for (int i = 0; i < 6; i++) {
    coreStats[i] = jsonStats.getJSONObject(i).getInt("value");
  }
}
