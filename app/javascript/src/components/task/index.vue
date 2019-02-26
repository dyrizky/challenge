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
                            <div id="example1_filter" class="col-lg-2 col-sm-2" >
                                <button class="btn btn-success" title="Add Some Task" @click="create()"><i class="fa fa-plus"></i></button>
                              </div>
                            <label class="col-sm-2 control-label">Show </label>
                            <div class="col-sm-3">
                    <select @click="show($event)" class="form-control input-sm">
                              <option selected="selected" value="10">10</option>
                              <option value="20">20</option>
                              <option value="30">30</option>
                              <option value="-1">All</option>
                              </select>
                  </div>
                             <label class="col-sm-3 control-label">entries</label>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="col-lg-12 col-sm-12 form-group" id="">
                            <label class="col-sm-2 control-label">Display </label>
                              <div id="example1_filter" class="col-lg-4 col-sm-4 ">
                                <toggle-button  @change="display($event)" color="#82C7EB" :sync="true" :width="70" :value="true" :labels="{checked: 'Table', unchecked: 'Card'}"/>
                              </div>
                              <div id="example1_filter" class="col-lg-4 col-sm-4" >
                                <toggle-button  @change="changePrev($event)" color="#82C7EB" :sync="true" :width="70" :value="true" :labels="{checked: 'All', unchecked: 'Previous'}" />
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
                  <th class="sorting_asc"
                @click="sortBy(coloums.due,'due')"
                >Due Date
                  <i class="fa fa-sort">
                  </i></th>
                  <th class="sorting_asc"
                @click="sortBy(coloums.prioriti,'prio')"
                >Priority
                  <i class="fa fa-sort">
                  </i></th>
                  
                </tr>
              </thead>
              <tbody  >
                <tr v-for="task,index in tasksData">
                  <td>{{index+number}}</td>
                  <td>
                  <label><input type="checkbox" v-if="task.is_complate" checked  @change="changeComplate(task.id)"> 
                  <input type="checkbox" v-else  @change="changeComplate(task.id)"> 
                    {{task.task}} &nbsp; <span v-if="task.is_complate" class="label label-success">Complate</span></label></td>
                  <td>{{task.task_desc}}</td>
                  <td>{{task.due_date}}</td>
                  <td><span v-if="task.prioriti==1" class="label label-danger">Priority</span></td>
                  
                </tr>
              </tbody>
              </table>
              <div v-else class="col-md-6 col-sm-6 col-xs-12" v-for="task,index in tasksData">
                <div class="info-box">
                  <span class="info-box-icon bg-aqua"><i class="fa fa-hourglass"></i></span>

                  <div class="info-box-content">
                    <span class="info-box-text"><label>Task : </label>{{task.task}}&nbsp; <span v-if="task.is_complate" class="label label-success">Complate</span></span>
                    <span class="info-box-number"><small><label>Task Description: </label>{{task.task_desc}}</small></span>
                    <label>Due Date : </label>{{task.due_date}}&nbsp; <span v-if="task.prioriti==1" class="label label-danger">Priority</span><br>
                    
                  </div>
                  <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
              </div>
              
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
          task :0,
          task_desc :0,
          prioriti :0,
          due :0,
        },
        page : 0,
        number : 1,
        limit : 10,
        table : 1,
        addOn : '',
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
        }else if(coloums == 'prio'){
          var order = "prioriti"+value[val]
          this.coloums.prioriti =  (val + 1) % 2
        }else if(coloums == 'due'){
          var order = "due_date"+value[val]
          this.coloums.due =  (val + 1) % 2
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
        this.table = event.value
        console.log(event.value);
      },
      changeComplate(data){
        var app  = this
        $.ajax({
          url: '/api/task/complate/'+data,
          method: 'PUT',
          dataType : "json",
          // data: "page="+app.page+"&order="+app.order+"&limit="+app.limit,
          success: function(data) {
            if(data.success == true){
              app.getResults(app.page);
              console.log(data)
            }
              console.log(data.success)
            
          }
        })
      },
      getPrev(page){
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
            $.ajax({
              url: '/api/task/prev',
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
      changePrev(event){
        if(event.value){
          this.getResults();
        }else{
          this.getPrev();
        }
        console.log(event.value);
      },create(){
        console.log("c")
        this.$router.push("/task/create")
      },
      
      
      
    }
  }

</script>
