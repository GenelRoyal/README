// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// app/javascript/packs/application.js
import Raty from 'raty-js';

// Railsアセットパイプラインを利用して画像パスを取得
const images = require.context('../images', true);
const starOn = images('./star-on.png');
const starOff = images('./star-off.png');

// DOMが読み込まれたら`raty`を初期化する処理
document.addEventListener('DOMContentLoaded', () => {
  // 評価入力用の要素を探して`raty`を適用
  document.querySelectorAll('.raty').forEach((element) => {
    const score = element.dataset.score || 0; // 初期スコアを取得
    new Raty(element, {
      score: score,
      starOn: starOn,     // 点灯した星
      starOff: starOff,   // 消灯した星
      scoreName: 'review[rating]', // フォームの送信名
    }).init();
  });
});