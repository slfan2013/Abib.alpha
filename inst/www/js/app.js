/**
 * INSPINIA - Responsive Admin Theme
 *
 */
(function () {
    angular.module('inspinia', [
        'ui.router',                    // Routing
        'oc.lazyLoad',                  // ocLazyLoad
        'ui.bootstrap',                 // Ui Bootstrap
        'pascalprecht.translate',       // Angular Translate
        'ngIdle',                       // Idle timer
        'ngSanitize'                    // ngSanitize
        ,'toaster'
        ,"ngMaterial"
        , 'ngMessages', 'material.svgAssetsCache',
        'data-table'
    ])
    .service("project_id_global_change_service", function(){
      if(localStorage.getItem("project_id_global")==null){
        var project_id_global = "";
      }else{
        var project_id_global = localStorage.getItem("project_id_global");
      }

      return {
        set_project_id:function(x){
          if(x !== project_id_global){
            localStorage.setItem("project_id_global", x)
            localStorage.setItem('activated_data_id', null)
            localStorage.setItem('activated_data_text', null)
            project_id_global = x
          }
        },
        get_project_id:function(){
          return project_id_global;
        }
      }
    })
    .service("upload_tree_trigger_service", function(){
      var update_trigger = false;
      return {
        set_update_tree_trigger:function(){
          update_trigger = true;
        },
        get_update_tree_trigger:function(){
          return update_trigger;
        }
      }
    })
    .service("get_filename_service", function(){
      return {
        get_filename:function(doc,pending_filename,sibling_id){
              // get filename.
              var tree = doc.tree_structure
              var id=[];var parent=[];var text=[];
              tree.map(function(x){
                id.push(x.id);parent.push(x.parent);text.push(x.text)
              })
              var input_parent = parent[id.indexOf(sibling_id)]
              var sibling_text_index = parent.reduce((a, e, i) => (e === input_parent) ? a.concat(i) : a, [])
              var sibling_text = sibling_text_index.map(i => text[i]);
              var sibling_text_duplicates_index = sibling_text.reduce((a, e, i) => (e.indexOf(pending_filename)!==-1) ? a.concat(i) : a, [])
              if(sibling_text_duplicates_index.length==0){
                var filename =pending_filename
              }else{
                var sibling_text_duplicates = sibling_text_duplicates_index.map(i => sibling_text[i]);
                var sibling_text_duplicates_numbers = sibling_text_duplicates.map(function(x){ return Number(x.replace( /^\D+/g, ''))})
                var filename =pending_filename+"_"+Number(Math.max(...sibling_text_duplicates_numbers)+1)
              }

              return(filename)
        }
      }
    })
    .service("get_parent_service",function(){
      return {
        get_parent:function(doc,sibling_id){
          var tree = doc.tree_structure
          var id=[];var parent=[];var text=[];
          tree.map(function(x){
            id.push(x.id);parent.push(x.parent);text.push(x.text)
          })
          var input_parent = parent[id.indexOf(sibling_id)]
          return(input_parent)
        }
      }
    })

})();

// Other libraries are loaded dynamically in the config.js file using the library ocLazyLoad
