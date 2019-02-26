import Vue from 'vue/dist/vue.esm';
import router from '../src/routes.js';
import Paginate from 'vuejs-paginate'
import ToggleButton from 'vue-js-toggle-button'
import Datepicker from 'vuejs-datepicker';
Vue.component('datepicker', Datepicker);

Vue.use(ToggleButton)
Vue.component('paginate', Paginate)

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  },
  complete: function(xhr, status) {
    // if(xhr.status === 200 || xhr.status === 422) {
    //   return true;
    // }
    if(xhr.status === 401) {
      return window.location.href = '/users/sign_in';
    }
    if(xhr.status === 404) {
      // return window.location.href = '/404';
    }
    if(xhr.status === 500) {
      // return window.location.href = '/500';
    }
    return true;
    // return window.location.href = '/500';
  }
})
// $.ajaxPrefilter(function( options ) {
//   options.url = `/${options.url}`;
// });

const app = new Vue({
  router, 
  
}).$mount('#app')
