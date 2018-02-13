/**
 * INSPINIA - Responsive Admin Theme
 *
 * Inspinia theme use AngularUI Router to manage routing and views
 * Each view are defined as state.
 * Initial there are written state for all view in theme.
 *
 */
function config($stateProvider, $urlRouterProvider, $ocLazyLoadProvider, IdleProvider, KeepaliveProvider) {

    // Configure Idle settings
    IdleProvider.idle(5); // in seconds
    IdleProvider.timeout(120); // in seconds

    $urlRouterProvider.otherwise("/landing_page");

    $ocLazyLoadProvider.config({
        // Set to true if you want to see what and when is dynamically loaded
        debug: false
    });

    $stateProvider

        .state('landing_page', {
            url: "/landing_page",
            templateUrl: "views/landing_page.html",
            data: { pageTitle: 'Landing page', specialClass: 'landing-page' },
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['js/plugins/wow/wow.min.js']
                        }
                    ]);
                }
            }
        })
        .state("content",{
          abstract: true,
          url: "/content",
          templateUrl:"views/common/content.html",
          resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            serie: true,
                            files: ['css/plugins/jsTree/style.min.css','js/plugins/jsTree/jstree.min.js']
                        }
                    ]);
                }
            }
        })
        .state('content.project_list', {
            url: "/project_list",
            templateUrl: "views/project_list.html",
            data: { pageTitle: 'Project List', module_name: "Project_List"}
        })
        .state('content.new_project', {
            url: "/new_project",
            templateUrl: "views/create_new_project.html",
            data: { pageTitle: 'New Project', module_name: "new_project"},
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['css/plugins/dropzone/basic.css','css/plugins/dropzone/dropzone.css','js/plugins/dropzone/dropzone.js']
                        },
                        {
                            files: ['js/plugins/jasny/jasny-bootstrap.min.js', 'css/plugins/jasny/jasny-bootstrap.min.css' ]
                        },
                        {
                            serie: true,
                            files: ['js/plugins/dataTables/datatables.min.js','css/plugins/dataTables/datatables.min.css']
                        },
                        {
                            serie: true,
                            name: 'datatables',
                            files: ['js/plugins/dataTables/angular-datatables.min.js']
                        },
                        {
                            serie: true,
                            name: 'datatables.buttons',
                            files: ['js/plugins/dataTables/angular-datatables.buttons.min.js']
                        },
                        {
                            name: 'ui.select',
                            files: ['js/plugins/ui-select/select.min.js', 'css/plugins/ui-select/select.min.css']
                        }
                    ]);
                }
            }
        })
        .state('content.view_project', {
            url: "/view_project",
            templateUrl: "views/view_project.html",
            data: { pageTitle: 'View Project', module_name: "view_project"},
            resolve: {
              loadPlugin: function($ocLazyLoad){
                return $ocLazyLoad.load([
                        {
                            files:["css/plugins/bootstrap-markdown/bootstrap-markdown.min.css","js/plugins/bootstrap-markdown/bootstrap-markdown.js","js/plugins/bootstrap-markdown/markdown.js",'js/papaparse.min.js']
                        }
                ])
              }
            }


        })
        .state("content.hypothesis_testing", {
          abstract: true,
          url: "/hypothesis_testing",
          templateUrl: "views/hypothesis_testing/hypothesis_test_framework.html",
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['js/pie.js','js/plotly-latest.min.js','js/papaparse.min.js','js/d3-scale-chromatic.v1.min.js','js/venn/canvas2svg.js','js/venn/jvenn.min.js']
                        }
                    ]);
                }
            }
        })
        .state("content.descriptive_statistics", {
          abstract: true,
          url: "/descriptive_statistics",
          templateUrl: "views/descriptive_statistics/descriptive_statistics_framework.html",
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['js/papaparse.min.js']
                        }
                    ]);
                }
            }
        })
        .state("content.descriptive_statistics.fold_change", {
          url: "/fold_change",
          templateUrl: "views/descriptive_statistics/fold_change.html",
          data: { pageTitle: "fold change", function_name: "fold_change", module_name: "fold change"}
        })
        .state("content.hypothesis_testing.t_test", {
          url: "/t_test",
          templateUrl: "views/hypothesis_testing/t_test.html",
          data: { pageTitle: "t test", function_name: "t_test", module_name: "t test"}
        })
        .state("content.hypothesis_testing.nonparametric_t_test", {
          url: "/mann_whitney_u_test",
          templateUrl: "views/hypothesis_testing/nonparametric_t_test.html",
          data: { pageTitle: "Mann Whitney U test", function_name: "nonparametric_t_test", module_name: "nonparametric t test"}
        })
        .state("content.hypothesis_testing.paired_t_test", {
          url: "/paired_t_test",
          templateUrl: "views/hypothesis_testing/paired_t_test.html",
          data: { pageTitle: "paired t test", function_name: "paired_t_test", module_name: "paired t test"}
        })
        .state("content.hypothesis_testing.nonparametric_paired_t_test", {
          url: "/wilcox_signed_rank_test",
          templateUrl: "views/hypothesis_testing/nonparametric_paired_t_test.html",
          data: { pageTitle: "Wilcoxon signed-rank test", function_name: "nonparametric_paired_t_test", module_name: "nonparametric paired t test"}
        })
        .state("content.hypothesis_testing.anova", {
          url: "/anova",
          templateUrl: "views/hypothesis_testing/anova.html",
          data: { pageTitle: "ANOVA", function_name: "anova", module_name: "ANOVA"}
        })
        .state("content.hypothesis_testing.nonparametric_anova", {
          url: "/kruskal_wallis_test",
          templateUrl: "views/hypothesis_testing/nonparametric_anova.html",
          data: { pageTitle: "Kruskal–Wallis test", function_name: "nonparametric_anova", module_name: "nonparametric ANOVA"}
        })
        .state("content.hypothesis_testing.repeated_anova", {
          url: "/repeated_anova",
          templateUrl: "views/hypothesis_testing/repeated_anova.html",
          data: { pageTitle: "repeated ANOVA", function_name: "repeated_anova", module_name: "repeated ANOVA"}
        })
        .state("content.hypothesis_testing.nonparametric_repeated_anova", {
          url: "/friedman_test",
          templateUrl: "views/hypothesis_testing/nonparametric_repeated_anova.html",
          data: { pageTitle: "Friedman test", function_name: "nonparametric_repeated_anova", module_name: "nonparametric repeated ANOVA"}
        })
        .state("content.hypothesis_testing.two_way_anova", {
          url: "/two_way_anova",
          templateUrl: "views/hypothesis_testing/two_way_anova.html",
          data: { pageTitle: "two way ANOVA", function_name: "two_way_anova", module_name: "two way ANOVA"}
        })
        .state("content.hypothesis_testing.two_way_mixed_anova", {
          url: "/two_way_mixed_anova",
          templateUrl: "views/hypothesis_testing/two_way_mixed_anova.html",
          data: { pageTitle: "two way mixed ANOVA", function_name: "two_way_mixed_anova", module_name: "two way mixed ANOVA"}
        })
        .state("content.dimension_reduction", {
          abstract: true,
          url: "/multivariate_analysis/dimension_reduction",
          templateUrl: "views/multivariate_analysis/dimension_reduction/dimension_reduction_framework.html",
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['js/plotly-latest.min.js','js/papaparse.min.js']
                        }
                    ]);
                }
            }
        })
        .state("content.dimension_reduction.pca", {
          url: "/pca",
          templateUrl: "views/multivariate_analysis/dimension_reduction/pca.html",
          data: { pageTitle: "Principal Component Analysis", function_name: "pca", module_name: "PCA"}
        })
        .state("content.dimension_reduction.pls", {
          url: "/pls",
          templateUrl: "views/multivariate_analysis/dimension_reduction/pls.html",
          data: { pageTitle: "Partial Least Square", function_name: "pls", module_name: "PLS"}
        })
        .state("content.filemanipulation", {
          abstract: true,
          url: "/filemanipulation",
          templateUrl: "views/file_manipulation/filemanipulation_framework.html",
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['js/papaparse.min.js','css/plugins/ionRangeSlider/ion.rangeSlider.css','css/plugins/ionRangeSlider/ion.rangeSlider.skinFlat.css','js/plugins/ionRangeSlider/ion.rangeSlider.min.js']
                        }
                    ]);
                }
            }
        })
        .state("content.filemanipulation.subsetting", {
          url: "/file_manipulation/subsetting",
          templateUrl: "views/file_manipulation/subsetting.html",
          data: { pageTitle: "Subsetting", function_name: "subsetting", module_name: "subsetting"}
        })
        .state("content.data_processing", {
          abstract: true,
          url: "/data_processing",
          templateUrl: "views/data_processing/data_processing_framework.html",
          resolve: {
              loadPlugin: function ($ocLazyLoad) {
                  return $ocLazyLoad.load([
                      {
                          files: ['js/pie.js','js/plotly-latest.min.js','js/papaparse.min.js','js/d3-scale-chromatic.v1.min.js']
                      }
                  ]);
              }
          }
        })
        .state("content.data_processing.data_transformation", {
          url: "/data_processing/data_transformation",
          templateUrl: "views/data_processing/data_transformation.html",
          data: { pageTitle: "data transformation", function_name: "data_transformation", module_name: "data transformation"}
        })
        /*.state("content.data_transformation", {
          abstract: true,
          url: "/data_transformation",
          templateUrl: "views/data_transformation/data_transformation_framework.html",
          resolve: {
              loadPlugin: function ($ocLazyLoad) {
                  return $ocLazyLoad.load([
                      {
                          files: ['js/pie.js','js/plotly-latest.min.js','js/papaparse.min.js','js/d3-scale-chromatic.v1.min.js']
                      }
                  ]);
              }
          }
        })
        .state("content.data_transformation.log", {
          url: "/data_transformation/log",
          templateUrl: "views/data_transformation/log.html",
          data: { pageTitle: "log transformation", function_name: "log_transformation", module_name: "log transformation"}
        })
        .state("content.data_transformation.power", {
          url: "/data_transformation/power",
          templateUrl: "views/data_transformation/power.html",
          data: { pageTitle: "power transformation", function_name: "power_transformation", module_name: "power transformation"}
        })*/
        .state("content.visualization", {
          abstract: true,
          url: "/visualization",
          templateUrl: "views/visualization/visualization_framework.html",
          resolve: {
              loadPlugin: function ($ocLazyLoad) {
                  return $ocLazyLoad.load([
                      {
                          files: ['js/pie.js','js/plotly-latest.min.js','js/papaparse.min.js','js/d3-scale-chromatic.v1.min.js','js/jszip.min.js', 'js/simple-statistics.js']
                      }
                  ]);
              }
          }
        })
        .state("content.visualization.boxplot", {
          url: "/visualization/boxplot",
          templateUrl: "views/visualization/boxplot.html",
          data: { pageTitle: "boxplot", function_name: "boxplot", module_name: "boxplot"}
        })
        .state("content.visualization.barplot", {
          url: "/visualization/barplot",
          templateUrl: "views/visualization/barplot.html",
          data: { pageTitle: "barplot", function_name: "barplot", module_name: "barplot"}
        })
        .state("content.visualization.linechart", {
          url: "/visualization/linechart",
          templateUrl: "views/visualization/linechart.html",
          data: { pageTitle: "linechart", function_name: "linechart", module_name: "linechart"}
        })
        .state("content.bimo", {
          abstract: true,
          url: "/bimo",
          templateUrl: "views/bimo/bimo_framework.html",
          resolve: {
              loadPlugin: function ($ocLazyLoad) {
                  return $ocLazyLoad.load([
                      {
                          files: ['js/pie.js','js/plotly-latest.min.js','js/papaparse.min.js','js/d3-scale-chromatic.v1.min.js','js/jszip.min.js', 'js/simple-statistics.js']
                      }
                  ]);
              }
          }
        })
        .state("content.bimo.scatter_plot", {
          url: "/bimo/scatter_plot",
          templateUrl: "views/bimo/scatter_plot.html",
          data: { pageTitle: "Scatter Plot", function_name: "scatter_plot", module_name: "scatter plot"}
        })

}
angular
    .module('inspinia')
    .config(config)
    .run(function($rootScope, $state) {
        $rootScope.$state = $state;
    });
