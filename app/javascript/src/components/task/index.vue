<template>
  
    <div >
    <div class="box box-danger" v-cloak>
        
        <div class="box-header with-border">
              <h1 class="box-title"><b></b></h1>
        </div>
    <div class="box-body">
              <div class="row">
                  <div class="col-sm-6">
                      <div class="col-lg-12 col-sm-12 form-group" id="">
                            <label class="col-sm-2 control-label">Show </label>
                            <div class="col-sm-3">
                    <select @click="show($event)" class="form-control input-sm">
                              <option value="5">5</option>
                              <option value="10">10</option>
                              <option value="25">25</option>
                              <option value="-1">All</option>
                              </select>
                  </div>
                             <label class="col-sm-3 control-label">entries</label>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="col-lg-12 col-sm-12 form-group" id="">
                            <label class="col-sm-2 control-label">Display </label>
                              <div id="example1_filter" class="dataTables_filter">
                                <toggle-button  @change="display($event)" color="#82C7EB" :sync="true" :width="70" :value="true" :labels="{checked: 'Table', unchecked: 'Card'}"/>
                              </div>
                          </div>
                    </div>
              </div>
              <div class="row col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <table v-if="table" class="table table-striped table-bordered">
              <thead>
              <tr >
              <th width="5%"class="sorting">No</th>
              <th class="sorting_asc"
                @click="sortBy(coloums.task,'task')"
                >Task
                  <i class="fa fa-sort">
                  </i>
                </th>
                  <th class="sorting_asc"
                @click="sortBy(coloums.task_desc,'desc')"
                >Desc
                  <i class="fa fa-sort">
                  </i></th>
                  <th class="sorting">Desc</th>
                  
                </tr>
              </thead>
              <tbody  >
                <tr v-for="task,index in tasksData">
                  <td>{{index+number}}</td>
                  <td>{{task.task}}</td>
                  <td>{{task.task_desc}}</td>
                  <td></td>
                </tr>
              </tbody>
              </table>
              <ul class="todo-list ui-sortable">
                <li class="">
                  <!-- drag handle -->
                  <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <!-- checkbox -->
                  <input type="checkbox" value="">
                  <!-- todo text -->
                  <span class="text">Design a nice theme</span>
                  <!-- Emphasis label -->
                  <small class="label label-danger"><i class="fa fa-clock-o"></i> 2 mins</small>
                  <!-- General tools such as edit or delete-->
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li>
                <li class="">
                      <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <input type="checkbox" value="">
                  <span class="text">Make the theme responsive</span>
                  <small class="label label-info"><i class="fa fa-clock-o"></i> 4 hours</small>
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li>
                <li>
                      <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <input type="checkbox" value="">
                  <span class="text">Let theme shine like a star</span>
                  <small class="label label-warning"><i class="fa fa-clock-o"></i> 1 day</small>
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li>
                <li>
                      <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <input type="checkbox" value="">
                  <span class="text">Let theme shine like a star</span>
                  <small class="label label-success"><i class="fa fa-clock-o"></i> 3 days</small>
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li>
                <li class="" style="">
                      <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <input type="checkbox" value="">
                  <span class="text">Let theme shine like a star</span>
                  <small class="label label-default"><i class="fa fa-clock-o"></i> 1 month</small>
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li><li>
                      <span class="handle ui-sortable-handle">
                        <i class="fa fa-ellipsis-v"></i>
                        <i class="fa fa-ellipsis-v"></i>
                      </span>
                  <input type="checkbox" value="">
                  <span class="text">Check your messages and notifications</span>
                  <small class="label label-primary"><i class="fa fa-clock-o"></i> 1 week</small>
                  <div class="tools">
                    <i class="fa fa-edit"></i>
                    <i class="fa fa-trash-o"></i>
                  </div>
                </li>
                
              </ul>
            <paginate v-if="tasks"
              :page-count="tasks"
              :click-handler="getResults"
              :prev-text="'«'"
              :next-text="'»'"
              :container-class="'pagination pagination-sm inline pull-right'">
            </paginate>
            </div>
    </div>
    </div>
  </div>
</template>

<script>
  
  export default {
    
    data: function() {
      return {
        tasksData : [],
        tasks : '',
        coloums : {
          task :1,
          task_desc :0,
        },
        page : 0,
        number : 1,
        limit : 5,
        table : 1,
        order : 'id'
      }
    },
    state: {
    
    },
    beforeCreate() {
        
    },
    mounted()  {
     var app = this;
     app.getResults();
    },
    methods: {
      getResults(page){
        var app = this;
        if(typeof page == 'undefined' || page == 0){
          page = 0;
          app.page = 0;
          app.number = 1;
        }else{
          app.page = page;
          page = (page -1)*app.limit;
          app.number = page+1;
        }
        // if(typeof order == 'undefined' ){
        //   console.log(order);
        //   order = 'id';
        // }
          // app.order = order;

            $.ajax({
              url: '/api/task',
              type: 'get',
              dataType : "json",
              data: "page="+page+"&order="+app.order+"&limit="+app.limit,
              success: function(data) {
                app.tasksData = data.data;
                if(data.length > app.limit && app.limit > 0 ){
                  app.tasks = Math.ceil(data.length/app.limit);
                  console.log("B")
                }else{
                  app.tasks = 0
                  console.log("A")
                }
                
              }
            })
      },
      sortBy(val,coloums){
        var value = [' ASC',' DESC'];
        if(coloums == 'task'){
          var order = "task"+value[val]
          this.coloums.task =  (val + 1) % 2
        }else if(coloums == 'desc'){
          var order = "task_desc"+value[val]
          this.coloums.task_desc =  (val + 1) % 2
        }
        this.order = order
         this.getResults(this.page);
        console.log(coloums);
        coloums = "desc";
      },
      show(event){
        this.limit =event.target.value; 
        this.getResults(this.page);
        console.log(event.target.value);

      },
      display(event){
        console.log(event.value);
      }
    }
  }

</script>
