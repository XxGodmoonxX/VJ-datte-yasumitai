//Syphon
import codeanticode.syphon.*;
SyphonServer server;

//画像
PImage img; //画像データ

//サウンド
import processing.sound.*;
//サウンド入力
AudioIn input;
//音量解析
Amplitude rms;

float volumeAdjust = 0.05;
int logoTranslate = 250;

void setup() {
  size(1000, 1000, P3D);
  PJOGL.profile = 1;
  server = new SyphonServer(this, "Processing Syphon");
  
  noStroke();
  fill(0, 50, 100);
  //画像を読み込み
  img = loadImage("breakdawn_6.png");
  //サウンド入力を初期化
  input = new AudioIn(this, 0);
  //サウンド入力を開始
  input.start();
  //音量解析を初期化
  rms = new Amplitude(this);
  //音量解析の入力を設定
  rms.input(input);
}

void draw() {
  background(0);
  //音量を解析して値を調整
  float diameter = map(rms.analyze(), 0, 1, 0, width/2);
  println(diameter);
  //画像を真ん中に表示
  imageMode(CENTER);
  scale(diameter * volumeAdjust);
  image(img, width/2/(diameter * volumeAdjust), height/2/(diameter * volumeAdjust));
  
  //斜め 左上→右下
  for (int i = 0; i < diameter ; i++) {
    pushMatrix();
    translate((i - 20) * logoTranslate, (i - 20) * logoTranslate);
    image(img, width/2/(diameter * volumeAdjust), height/2/(diameter * volumeAdjust));
    popMatrix();
  }
  
  //斜め 右上→左下
  for (int i = 0; i < diameter ; i++) {
    pushMatrix();
    translate((i - 20) * logoTranslate, (i - 20) * -logoTranslate);
    image(img, width/2/(diameter * volumeAdjust), height/2/(diameter * volumeAdjust));
    popMatrix();
  }
  
  //横
  for (int i = 0; i < diameter ; i++) {
    pushMatrix();
    translate((i - 20) * logoTranslate, 0);
    image(img, width/2/(diameter * volumeAdjust), height/2/(diameter * volumeAdjust));
    popMatrix();
  }
  
  //縦
  for (int i = 0; i < diameter ; i++) {
    pushMatrix();
    translate(0, (i - 20) * logoTranslate);
    image(img, width/2/(diameter * volumeAdjust), height/2/(diameter * volumeAdjust));
    popMatrix();
  }
  
  //SyphonServerに送る
  server.sendScreen();
}