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


// タグ機能、チェックボックスに関するjs
document.addEventListener("turbolinks:load", function(){
  var sentiment_checkboxes = document.querySelectorAll('.sentiment_checkbox');
    sentiment_checkboxes.forEach(function(element) {
        element.addEventListener('click', function() {
            var siblingElements = this.parentNode.children;
            for (var i = 0; i < siblingElements.length; i++) {
                if (siblingElements[i] !== this && siblingElements[i].classList.contains('form-check-text')) {
                    siblingElements[i].classList.toggle('clicked');
                }
            }
        });
    });

})