import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import Error500 from './components/errors/500.vue';
import Error404 from './components/errors/404.vue';
import TaskIndex from './components/task/index.vue';

const router = new VueRouter({
  mode: 'history',
  // base: `${I18n.prefix}`,
  routes: [
    { path: '/', redirect: '/task'},
    { path: '/task', component: TaskIndex, name: 'root_path' },
    { path: '/500', component: Error500 },
    { path: '/404', component: Error404 },
    { path: '*', redirect: '/404' }
  ]
});

export default router;
