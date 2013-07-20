/* ============================================================
 * bootstrap-dropdown.js v2.3.2
 * http://twitter.github.com/bootstrap/javascript.html#dropdowns
 * ============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(e){"use strict";function t(){e(".dropdown-backdrop").remove(),e(r).each(function(){n(e(this)).removeClass("open")})}function n(t){var n,r=t.attr("data-target");return r||(r=t.attr("href"),r=r&&/#/.test(r)&&r.replace(/.*(?=#[^\s]*$)/,"")),n=r&&e(r),n&&n.length||(n=t.parent()),n}var r="[data-toggle=dropdown]",i=function(t){var n=e(t).on("click.dropdown.data-api",this.toggle);e("html").on("click.dropdown.data-api",function(){n.parent().removeClass("open")})};i.prototype={constructor:i,toggle:function(){var r,i,o=e(this);if(!o.is(".disabled, :disabled"))return r=n(o),i=r.hasClass("open"),t(),i||("ontouchstart"in document.documentElement&&e('<div class="dropdown-backdrop"/>').insertBefore(e(this)).on("click",t),r.toggleClass("open")),o.focus(),!1},keydown:function(t){var i,o,a,s,l;if(/(38|40|27)/.test(t.keyCode)&&(i=e(this),t.preventDefault(),t.stopPropagation(),!i.is(".disabled, :disabled"))){if(a=n(i),s=a.hasClass("open"),!s||s&&27==t.keyCode)return 27==t.which&&a.find(r).focus(),i.click();o=e("[role=menu] li:not(.divider):visible a",a),o.length&&(l=o.index(o.filter(":focus")),38==t.keyCode&&l>0&&l--,40==t.keyCode&&l<o.length-1&&l++,~l||(l=0),o.eq(l).focus())}}};var o=e.fn.dropdown;e.fn.dropdown=function(t){return this.each(function(){var n=e(this),r=n.data("dropdown");r||n.data("dropdown",r=new i(this)),"string"==typeof t&&r[t].call(n)})},e.fn.dropdown.Constructor=i,e.fn.dropdown.noConflict=function(){return e.fn.dropdown=o,this},e(document).on("click.dropdown.data-api",t).on("click.dropdown.data-api",".dropdown form",function(e){e.stopPropagation()}).on("click.dropdown.data-api",r,i.prototype.toggle).on("keydown.dropdown.data-api",r+", [role=menu]",i.prototype.keydown)}(window.jQuery);