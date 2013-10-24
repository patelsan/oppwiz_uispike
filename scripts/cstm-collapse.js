/* =============================================================
 * bootstrap-collapse.js v2.0.2
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

! function($) {
    "use strict";

    $(function() {
        $('body').on('click.collapse.data-api', '[data-toggle=collapse]', function(e) {
          e.preventDefault();
          var $this = $(this),
            hrf = $this.attr('href');
            if( $(hrf).hasClass('open') ){
              $(hrf).removeClass('open');
            }else{
              $('.accordion-group').removeClass('open').filter(hrf).addClass('open');
            }
        });
    });

}(window.jQuery);