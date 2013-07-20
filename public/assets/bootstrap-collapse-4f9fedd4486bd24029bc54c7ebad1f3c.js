/* =============================================================
 * bootstrap-collapse.js v2.3.2
 * http://twitter.github.com/bootstrap/javascript.html#collapse
 * =============================================================
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
!function(e){"use strict";var t=function(t,n){this.$element=e(t),this.options=e.extend({},e.fn.collapse.defaults,n),this.options.parent&&(this.$parent=e(this.options.parent)),this.options.toggle&&this.toggle()};t.prototype={constructor:t,dimension:function(){var e=this.$element.hasClass("width");return e?"width":"height"},show:function(){var t,n,r,i;if(!this.transitioning&&!this.$element.hasClass("in")){if(t=this.dimension(),n=e.camelCase(["scroll",t].join("-")),r=this.$parent&&this.$parent.find("> .accordion-group > .in"),r&&r.length){if(i=r.data("collapse"),i&&i.transitioning)return;r.collapse("hide"),i||r.data("collapse",null)}this.$element[t](0),this.transition("addClass",e.Event("show"),"shown"),e.support.transition&&this.$element[t](this.$element[0][n])}},hide:function(){var t;!this.transitioning&&this.$element.hasClass("in")&&(t=this.dimension(),this.reset(this.$element[t]()),this.transition("removeClass",e.Event("hide"),"hidden"),this.$element[t](0))},reset:function(e){var t=this.dimension();return this.$element.removeClass("collapse")[t](e||"auto")[0].offsetWidth,this.$element[null!==e?"addClass":"removeClass"]("collapse"),this},transition:function(t,n,r){var i=this,o=function(){"show"==n.type&&i.reset(),i.transitioning=0,i.$element.trigger(r)};this.$element.trigger(n),n.isDefaultPrevented()||(this.transitioning=1,this.$element[t]("in"),e.support.transition&&this.$element.hasClass("collapse")?this.$element.one(e.support.transition.end,o):o())},toggle:function(){this[this.$element.hasClass("in")?"hide":"show"]()}};var n=e.fn.collapse;e.fn.collapse=function(n){return this.each(function(){var r=e(this),i=r.data("collapse"),o=e.extend({},e.fn.collapse.defaults,r.data(),"object"==typeof n&&n);i||r.data("collapse",i=new t(this,o)),"string"==typeof n&&i[n]()})},e.fn.collapse.defaults={toggle:!0},e.fn.collapse.Constructor=t,e.fn.collapse.noConflict=function(){return e.fn.collapse=n,this},e(document).on("click.collapse.data-api","[data-toggle=collapse]",function(t){var n,r=e(this),i=r.attr("data-target")||t.preventDefault()||(n=r.attr("href"))&&n.replace(/.*(?=#[^\s]+$)/,""),o=e(i).data("collapse")?"toggle":r.data();r[e(i).hasClass("in")?"addClass":"removeClass"]("collapsed"),e(i).collapse(o)})}(window.jQuery);