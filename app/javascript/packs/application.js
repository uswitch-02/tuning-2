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
import "./vivus";
import "../stylesheets/application";
import '../stylesheets/mystyle.css'
// import '@fontawesome/fontawesome-free/js/all'
require('jquery')
Rails.start()
Turbolinks.start()
ActiveStorage.start()


document.addEventListener("turbolinks:load", function(){
  var maxSelection = 3; // 最大選択個数を設定
  var sentiment_checkboxes = document.querySelectorAll('.sentiment_checkbox');

  sentiment_checkboxes.forEach(function(element) {
    element.addEventListener('click', function() {
      var selectedCount = 0;

      sentiment_checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
          selectedCount++;
        }
      });

      // 選択個数が制限を超えた場合、選択を無効化
      if (selectedCount > maxSelection) {
        this.checked = !this.checked; // チェックを戻す
        return; // クリックを無効化して終了
      }

      var siblingElements = this.parentNode.children;
      for (var i = 0; i < siblingElements.length; i++) {
        if (siblingElements[i] !== this && siblingElements[i].classList.contains('form-check-text')) {
          siblingElements[i].classList.toggle('clicked');
        }
      }
    });
  });
});