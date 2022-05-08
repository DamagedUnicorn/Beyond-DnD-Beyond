void addButtons() {

  cp5.addButton("check1") .setLabel("Acrobatics")    .setPosition(50, 100) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check2") .setLabel("Animal Hand.")  .setPosition(50, 200) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check3") .setLabel("Arcana")        .setPosition(50, 300) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check4") .setLabel("Athletics")     .setPosition(50, 400) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[0]);
  cp5.addButton("check5") .setLabel("Deception")     .setPosition(50, 500) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check6") .setLabel("History")       .setPosition(50, 600) .setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check7") .setLabel("Insight")       .setPosition(225, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check8") .setLabel("Intimidation")  .setPosition(225, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check9") .setLabel("Investigation") .setPosition(225, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check10").setLabel("Medicine")      .setPosition(225, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check11").setLabel("Nature")        .setPosition(225, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check12").setLabel("Perception")    .setPosition(225, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("check13").setLabel("Performance")   .setPosition(400, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check14").setLabel("Persuasion")    .setPosition(400, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);
  cp5.addButton("check15").setLabel("Religion")      .setPosition(400, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("check16").setLabel("Sleight of Ha.").setPosition(400, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check17").setLabel("Stealth")       .setPosition(400, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("check18").setLabel("Survival")      .setPosition(400, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);

  cp5.addButton("save1").setLabel("STR save").setPosition(width/2-buttonWidth/2, 100).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[0]);
  cp5.addButton("save2").setLabel("DEX save").setPosition(width/2-buttonWidth/2, 200).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[1]);
  cp5.addButton("save3").setLabel("CON save").setPosition(width/2-buttonWidth/2, 300).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[2]);
  cp5.addButton("save4").setLabel("INT save").setPosition(width/2-buttonWidth/2, 400).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[3]);
  cp5.addButton("save5").setLabel("WIS save").setPosition(width/2-buttonWidth/2, 500).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[4]);
  cp5.addButton("save6").setLabel("CHA save").setPosition(width/2-buttonWidth/2, 600).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(statColors[5]);

  cp5.addButton("initiative").setLabel("Initiative").setPosition(50, 750).setSize(buttonWidth, buttonHeight).setFont(font).setColorBackground(color(255, 0, 0));

  for (int i = 0; i < weaponListLen; i++) {
    if (weapons[i] != null) {
      cp5.addButton("attack" + str(i+1)).setLabel(weapons[i]).setPosition(width-250, (i+1)*100).setSize(buttonWidth, buttonHeight).setFont(font);
    }
  }
}
