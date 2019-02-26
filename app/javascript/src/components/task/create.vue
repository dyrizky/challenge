<style>
  [v-cloak] {
    display: none;
  }
  .vdp-datepicker__calendar.my-datepicker_calendar {
    width: 100%;
    font-size:14px;
    }
</style>
<template>
    <div>
      <div class="col-lg-3"></div>
    <div class="box box-danger" v-cloak style="width:50%">
        
        <div class="box-header with-border">
              <h1 class="box-title"><b>{{reservasi}}</b></h1>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-8 col-sm-8 col-xs-12 form-group">
                    <label for="rm">Task</label>
                    <div class="input-group" id="rm">
                        <span class="input-group-addon"><i class="fa fa-pencil"></i></span>
                        <input type="text" autocomplete="off" v-model="task.task" name="task" class="form-control" placeholder="">
                    </div>
                    <span v-if="errors.task" class="label label-danger">{{errors.task}}</span>
                    <span v-else class="label label-default"></span>
                <!-- /.info-box -->
                </div>
                <div class="col-md-8 col-sm-8 col-xs-12 form-group">
                    <label for="due-date">Due Date</label>
                    <div class="input-group" id="due-date" >
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <!-- <input type="text" v-model="pasien.tglLahir" name="tglLahir" class="form-control" placeholder=""> -->
                        <datepicker v-model="task.due_date" input-class="form-control my-datepicker" calendar-class="my-datepicker_calendar" name="tglLahir"></datepicker>
                    </div>
                    <span v-if="errors.due_date" class="label label-danger">{{errors.due_date}}</span>
                    <span v-else class="label label-default"></span>
                <!-- /.info-box -->
                </div>
                <div class="col-md-8 col-sm-8 col-xs-12 form-group">
                    <label for="">Desc</label>
                    <div class="input-group" id="">
                        <span class="input-group-addon"><i class="fa fa-clone"></i></span>
                      <textarea class="form-control" v-model="task.task_desc"> </textarea>
                    </div>
                    <span v-if="errors.task_desc" class="label label-danger">{{errors.task_desc}}</span>
                    <span v-else class="label label-default"></span>
                </div>
                     <div class="col-md-8 col-sm-8 col-xs-12 form-group">
                    <label for="">Priority</label>
                    <div class="input-group" id="bpjs">
                        <span class="input-group-addon"><i class="fa fa-clone"></i></span>
                        <select v-model="task.priority" class="form-control">
                          <option value="1">Priority</option>
                          <option value="0">Not Priority</option>
                        </select>
                    </div>
                    <span v-if="errors.priority" class="label label-danger">{{errors.priority}}</span>
                    <span v-else class="label label-default"></span>
                </div>
                
                <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                    <div class="col-md-3 col-sm-3 col-xs-3" style="align:right" >
                   <!-- <router-link :to="{name:'HomePage'}"  tag="a" class="btn btn-app" >
                        <i class="fa fa-step-backward"></i> Back
                    </router-link>-->
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6"  >
                    <a v-on:click="simpan" class="btn btn-app">
                        <i class="fa fa-save"></i> Save
                    </a>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-3" style="align:right" >
                   
                    </div>
                    
                    
              </div>
            </div>
            
        </div>
    </div>
        <div class="col-lg-3"></div>
    </div>

</template>
<script>
  export default {
    data: function() {
      return {
        reservasi: '',
        task : {
          task:'',
          task_desc:'',
          due_date:'',
          priority:''
        },
        errors: {
            task:'',
          task_desc:'',
          due_date:'',
          priority:''

        }    
    }
    },
    
    mounted()  {
     var app = this;
    },
    methods: {
      simpan() {
        var app = this
        console.log(this.task);
        console.log(app.task.task)
        var error = 4;
            if(this.task.task == '' ){
            //   console.log("kosong")
            app.errors.task = "Task tidak boleh kosong"
            //   console.log(app.errors.task)
            }else{
                error = error-1;
                app.errors.task = ""
            }
            if(this.task.task_desc == '' ){
                app.errors.task_desc = "Task Desc tidak boleh kosong"
            }else{
                error = error-1;
                app.errors.task_desc = ""
            }
            if(this.task.due_date == '' ){
                app.errors.due_date = "Due Date tidak boleh kosong"
            }else{
                error = error-1;
                app.errors.due_date = ""
            }
            if(this.task.priority == '' ){
                app.errors.priority = "Priority tidak boleh kosong"
            }else{
                error = error-1;
                app.errors.priority = ""
            }
            if(error == 0){
                $.ajax({
                url: '/api/task/store',
                type: 'post',
                // dataType : "json",
                data : {
                    task : app.task.task,
                    task_desc : app.task.task_desc,
                    due_date : app.task.due_date,
                    prioriti : app.task.priority
                },
                success: function(data) {
                    app.$router.push("/task")
                    
                }
                })
            }
        }
      }
    
  }

</script>
