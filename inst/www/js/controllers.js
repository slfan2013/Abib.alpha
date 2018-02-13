function MainCtrl($scope, $http) {


    /**
     * countries - Used as duallistbox in form advanced view
     */

    this.countries = [
        { name: 'Amsterdam' },
        { name: 'Washington' },
        { name: 'Sydney' },
        { name: 'Cairo' },
        { name: 'Beijing' }];

    this.getLocation = function(val) {
        return $http.get('//maps.googleapis.com/maps/api/geocode/json', {
            params: {
                address: val,
                sensor: false
            }
        }).then(function(response){
            return response.data.results.map(function(item){
                return item.formatted_address;
            });
        });
    };

    /**
     * daterange - Used as initial model for data range picker in Advanced form view
     */
    this.daterange = {startDate: null, endDate: null};

    /**
     * slideInterval - Interval for bootstrap Carousel, in milliseconds:
     */
    this.slideInterval = 5000;

    /**
     * tags - Used as advanced forms view in input tag control
     */

    this.tags = [
        { text: 'Amsterdam' },
        { text: 'Washington' },
        { text: 'Sydney' },
        { text: 'Cairo' },
        { text: 'Beijing' }
    ];

    /**
     * states - Data used in Advanced Form view for Chosen plugin
     */
    this.states = [
        'Alabama',
        'Alaska',
        'Arizona',
        'Arkansas',
        'California',
        'Colorado',
        'Connecticut',
        'Delaware',
        'Florida',
        'Georgia',
        'Hawaii',
        'Idaho',
        'Illinois',
        'Indiana',
        'Iowa',
        'Kansas',
        'Kentucky',
        'Louisiana',
        'Maine',
        'Maryland',
        'Massachusetts',
        'Michigan',
        'Minnesota',
        'Mississippi',
        'Missouri',
        'Montana',
        'Nebraska',
        'Nevada',
        'New Hampshire',
        'New Jersey',
        'New Mexico',
        'New York',
        'North Carolina',
        'North Dakota',
        'Ohio',
        'Oklahoma',
        'Oregon',
        'Pennsylvania',
        'Rhode Island',
        'South Carolina',
        'South Dakota',
        'Tennessee',
        'Texas',
        'Utah',
        'Vermont',
        'Virginia',
        'Washington',
        'West Virginia',
        'Wisconsin',
        'Wyoming'
    ];

    /**
     * check's - Few variables for checkbox input used in iCheck plugin. Only for demo purpose
     */
    this.checkOne = true;
    this.checkTwo = true;
    this.checkThree = true;
    this.checkFour = true;

    /**
     * knobs - Few variables for knob plugin used in Advanced Plugins view
     */
    this.knobOne = 75;
    this.knobTwo = 25;
    this.knobThree = 50;

    /**
     * Variables used for Ui Elements view
     */
    this.bigTotalItems = 175;
    this.bigCurrentPage = 1;
    this.maxSize = 5;
    this.singleModel = false;
    this.radioModel = 'Middle';
    this.checkModel = {
        left: false,
        middle: true,
        right: false
    };

    /**
     * groups - used for Collapse panels in Tabs and Panels view
     */
    this.groups = [
        {
            title: 'Dynamic Group Header - 1',
            content: 'Dynamic Group Body - 1'
        },
        {
            title: 'Dynamic Group Header - 2',
            content: 'Dynamic Group Body - 2'
        }
    ];

    /**
     * alerts - used for dynamic alerts in Notifications and Tooltips view
     */
    this.alerts = [
        { type: 'danger', msg: 'Oh snap! Change a few things up and try submitting again.' },
        { type: 'success', msg: 'Well done! You successfully read this important alert message.' },
        { type: 'info', msg: 'OK, You are done a great job man.' }
    ];

    /**
     * addAlert, closeAlert  - used to manage alerts in Notifications and Tooltips view
     */
    this.addAlert = function() {
        this.alerts.push({msg: 'Another alert!'});
    };

    this.closeAlert = function(index) {
        this.alerts.splice(index, 1);
    };

    /**
     * randomStacked - used for progress bar (stacked type) in Badges adn Labels view
     */
    this.randomStacked = function() {
        this.stacked = [];
        var types = ['success', 'info', 'warning', 'danger'];

        for (var i = 0, n = Math.floor((Math.random() * 4) + 1); i < n; i++) {
            var index = Math.floor((Math.random() * 4));
            this.stacked.push({
                value: Math.floor((Math.random() * 30) + 1),
                type: types[index]
            });
        }
    };
    /**
     * initial run for random stacked value
     */
    this.randomStacked();

    /**
     * summernoteText - used for Summernote plugin
     */
    this.summernoteText = ['<h3>Hello Jonathan! </h3>',
    '<p>dummy text of the printing and typesetting industry. <strong>Lorem Ipsum has been the dustrys</strong> standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more',
        'recently with</p>'].join('');

    /**
     * General variables for Peity Charts
     * used in many view so this is in Main controller
     */
    this.BarChart = {
        data: [5, 3, 9, 6, 5, 9, 7, 3, 5, 2, 4, 7, 3, 2, 7, 9, 6, 4, 5, 7, 3, 2, 1, 0, 9, 5, 6, 8, 3, 2, 1],
        options: {
            fill: ["#1ab394", "#d7d7d7"],
            width: 100
        }
    };

    this.BarChart2 = {
        data: [5, 3, 9, 6, 5, 9, 7, 3, 5, 2],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };

    this.BarChart3 = {
        data: [5, 3, 2, -1, -3, -2, 2, 3, 5, 2],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };

    this.LineChart = {
        data: [5, 9, 7, 3, 5, 2, 5, 3, 9, 6, 5, 9, 4, 7, 3, 2, 9, 8, 7, 4, 5, 1, 2, 9, 5, 4, 7],
        options: {
            fill: '#1ab394',
            stroke: '#169c81',
            width: 64
        }
    };

    this.LineChart2 = {
        data: [3, 2, 9, 8, 47, 4, 5, 1, 2, 9, 5, 4, 7],
        options: {
            fill: '#1ab394',
            stroke: '#169c81',
            width: 64
        }
    };

    this.LineChart3 = {
        data: [5, 3, 2, -1, -3, -2, 2, 3, 5, 2],
        options: {
            fill: '#1ab394',
            stroke: '#169c81',
            width: 64
        }
    };

    this.LineChart4 = {
        data: [5, 3, 9, 6, 5, 9, 7, 3, 5, 2],
        options: {
            fill: '#1ab394',
            stroke: '#169c81',
            width: 64
        }
    };

    this.PieChart = {
        data: [1, 5],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };

    this.PieChart2 = {
        data: [226, 360],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };
    this.PieChart3 = {
        data: [0.52, 1.561],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };
    this.PieChart4 = {
        data: [1, 4],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };
    this.PieChart5 = {
        data: [226, 134],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };
    this.PieChart6 = {
        data: [0.52, 1.041],
        options: {
            fill: ["#1ab394", "#d7d7d7"]
        }
    };
};


/**
 *
 * Pass all functions into module
 */
angular
    .module('inspinia')
    .controller('MainCtrl', MainCtrl)
    .controller('landing_page_controller', function($scope,$window,$mdDialog, $mdToast) {
      // check if this PC is using MetDA. If so, we don't need to create a user. Otherwise, create a user, using ip and time.
      var ip;
      $.get("http://ipinfo.io", function(response) {ip = response.ip;}, "jsonp");
      $scope.go = function(){

      if(localStorage.getItem("username") === null){
           // clear the storage.
           localStorage.clear();

            var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');

            var date = new Date();
            var date_num = date.getTime();


             var new_user = {
                    "_id":"AUTO_CREATED_USER_68410298_"+date_num,
                    "password":"",
                    "email":"",
                    "project_list":[],
                    "ip_address":[ip + "_68410298_" + date],
                    "create_time":date,
                    "saved_plot_data":[
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "legendgroup": "",
               "name": "",
               "mode": "markers+text",
               "text": [
               ],
               "textposition": "top center",
               "textfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#00ff00"
               },
               "marker": {
                   "symbol": "square-dot",
                   "color": "#c7f275",
                   "opacity": 1,
                   "size": 12,
                   "colorscale": "Greys",
                   "showscale": false,
                   "colorbar": {
                       "thicknessmode": "pixels",
                       "thickness": 100,
                       "lenmode": "pixels",
                       "len": 400,
                       "x": 1,
                       "xanchor": "left",
                       "xpad": 20,
                       "y": 0.5,
                       "yanchor": "top",
                       "ypad": 10,
                       "outlinecolor": "green",
                       "outlinewidth": 2,
                       "bordercolor": "red",
                       "borderwidth": 2,
                       "bgcolor": "yellow",
                       "tickmode": "array",
                       "nticks": 6,
                       "tickvals": [
                           1,
                           2
                       ],
                       "ticktext": [
                           1,
                           20
                       ],
                       "ticks": "outside",
                       "ticklen": 12,
                       "tickwidth": 12,
                       "tickcolor": "red",
                       "showticklabels": true,
                       "tickfont": {
                           "family": "Arial",
                           "size": 16,
                           "color": "green"
                       },
                       "tickangle": 45,
                       "title": "right",
                       "titlefont": {
                           "family": "Arial",
                           "size": 15,
                           "color": "blue"
                       },
                       "titleside": "right"
                   },
                   "line": {
                       "width": 1,
                       "color": "#000000"
                   },
                   "cmin": 2,
                   "cmax": 7,
                   "cauto": true
               },
               "fill": "none",
               "fillcolor": "#ffffff",
               "uid": "3691e4",
               "$$hashKey": "object:2965"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "legendgroup": "",
               "name": "",
               "mode": "markers+text",
               "text": [
               ],
               "textposition": "top center",
               "textfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#00ff00"
               },
               "marker": {
                   "symbol": "circle",
                   "color": "#ff69b4",
                   "opacity": 1,
                   "size": 12,
                   "colorscale": "Greys",
                   "showscale": false,
                   "colorbar": {
                       "thicknessmode": "pixels",
                       "thickness": 100,
                       "lenmode": "pixels",
                       "len": 400,
                       "x": 1,
                       "xanchor": "left",
                       "xpad": 20,
                       "y": 0.5,
                       "yanchor": "top",
                       "ypad": 10,
                       "outlinecolor": "green",
                       "outlinewidth": 2,
                       "bordercolor": "red",
                       "borderwidth": 2,
                       "bgcolor": "yellow",
                       "tickmode": "array",
                       "nticks": 6,
                       "tickvals": [
                           1,
                           2
                       ],
                       "ticktext": [
                           1,
                           20
                       ],
                       "ticks": "outside",
                       "ticklen": 12,
                       "tickwidth": 12,
                       "tickcolor": "red",
                       "showticklabels": true,
                       "tickfont": {
                           "family": "Arial",
                           "size": 16,
                           "color": "green"
                       },
                       "tickangle": 45,
                       "title": "right",
                       "titlefont": {
                           "family": "Arial",
                           "size": 15,
                           "color": "blue"
                       },
                       "titleside": "right"
                   },
                   "line": {
                       "width": 1,
                       "color": "#000000"
                   },
                   "cmin": 4,
                   "cmax": 9,
                   "cauto": true
               },
               "fill": "none",
               "fillcolor": "#ffffff",
               "uid": "c1845e",
               "$$hashKey": "object:524"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "legendgroup": "",
               "name": "",
               "mode": "markers+text",
               "text": [
               ],
               "textposition": "top center",
               "textfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#00ff00"
               },
               "marker": {
                   "symbol": "circle",
                   "color": "#ff69b4",
                   "opacity": 1,
                   "size": 12,
                   "colorscale": "Greys",
                   "showscale": false,
                   "colorbar": {
                       "thicknessmode": "pixels",
                       "thickness": 100,
                       "lenmode": "pixels",
                       "len": 400,
                       "x": 1,
                       "xanchor": "left",
                       "xpad": 20,
                       "y": 0.5,
                       "yanchor": "top",
                       "ypad": 10,
                       "outlinecolor": "green",
                       "outlinewidth": 2,
                       "bordercolor": "red",
                       "borderwidth": 2,
                       "bgcolor": "yellow",
                       "tickmode": "array",
                       "nticks": 6,
                       "tickvals": [
                           1,
                           2
                       ],
                       "ticktext": [
                           1,
                           20
                       ],
                       "ticks": "outside",
                       "ticklen": 12,
                       "tickwidth": 12,
                       "tickcolor": "red",
                       "showticklabels": true,
                       "tickfont": {
                           "family": "Arial",
                           "size": 16,
                           "color": "green"
                       },
                       "tickangle": 45,
                       "title": "right",
                       "titlefont": {
                           "family": "Arial",
                           "size": 15,
                           "color": "blue"
                       },
                       "titleside": "right"
                   },
                   "line": {
                       "width": 1,
                       "color": "#000000"
                   },
                   "cmin": 4,
                   "cmax": 9,
                   "cauto": true
               },
               "fill": "none",
               "fillcolor": "#ffffff",
               "uid": "0c0913",
               "$$hashKey": "object:525"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "legendgroup": "",
               "name": "",
               "mode": "markers+text",
               "text": [
               ],
               "textposition": "top center",
               "textfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#00ff00"
               },
               "marker": {
                   "symbol": "circle",
                   "color": "#ff69b4",
                   "opacity": 1,
                   "size": 12,
                   "colorscale": "Greys",
                   "showscale": false,
                   "colorbar": {
                       "thicknessmode": "pixels",
                       "thickness": 100,
                       "lenmode": "pixels",
                       "len": 400,
                       "x": 1,
                       "xanchor": "left",
                       "xpad": 20,
                       "y": 0.5,
                       "yanchor": "top",
                       "ypad": 10,
                       "outlinecolor": "green",
                       "outlinewidth": 2,
                       "bordercolor": "red",
                       "borderwidth": 2,
                       "bgcolor": "yellow",
                       "tickmode": "array",
                       "nticks": 6,
                       "tickvals": [
                           1,
                           2
                       ],
                       "ticktext": [
                           1,
                           20
                       ],
                       "ticks": "outside",
                       "ticklen": 12,
                       "tickwidth": 12,
                       "tickcolor": "red",
                       "showticklabels": true,
                       "tickfont": {
                           "family": "Arial",
                           "size": 16,
                           "color": "green"
                       },
                       "tickangle": 45,
                       "title": "right",
                       "titlefont": {
                           "family": "Arial",
                           "size": 15,
                           "color": "blue"
                       },
                       "titleside": "right"
                   },
                   "line": {
                       "width": 1,
                       "color": "#000000"
                   },
                   "cmin": 4,
                   "cmax": 9,
                   "cauto": true
               },
               "fill": "none",
               "fillcolor": "#ffffff",
               "uid": "25cec5",
               "$$hashKey": "object:526"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "legendgroup": "",
               "name": "",
               "mode": "markers+text",
               "text": [
               ],
               "textposition": "top center",
               "textfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#00ff00"
               },
               "marker": {
                   "symbol": "circle",
                   "color": "#ff69b4",
                   "opacity": 1,
                   "size": 12,
                   "colorscale": "Greys",
                   "showscale": false,
                   "colorbar": {
                       "thicknessmode": "pixels",
                       "thickness": 100,
                       "lenmode": "pixels",
                       "len": 400,
                       "x": 1,
                       "xanchor": "left",
                       "xpad": 20,
                       "y": 0.5,
                       "yanchor": "top",
                       "ypad": 10,
                       "outlinecolor": "green",
                       "outlinewidth": 2,
                       "bordercolor": "red",
                       "borderwidth": 2,
                       "bgcolor": "yellow",
                       "tickmode": "array",
                       "nticks": 6,
                       "tickvals": [
                           1,
                           2
                       ],
                       "ticktext": [
                           1,
                           20
                       ],
                       "ticks": "outside",
                       "ticklen": 12,
                       "tickwidth": 12,
                       "tickcolor": "red",
                       "showticklabels": true,
                       "tickfont": {
                           "family": "Arial",
                           "size": 16,
                           "color": "green"
                       },
                       "tickangle": 45,
                       "title": "right",
                       "titlefont": {
                           "family": "Arial",
                           "size": 15,
                           "color": "blue"
                       },
                       "titleside": "right"
                   },
                   "line": {
                       "width": 1,
                       "color": "#000000"
                   },
                   "cmin": 4,
                   "cmax": 9,
                   "cauto": true
               },
               "fill": "none",
               "fillcolor": "#ffffff",
               "uid": "b5d27f",
               "$$hashKey": "object:527"
           }
       ],
                    "saved_plot_layout":{
           "width": 840,
           "height": 450,
           "margin_open": false,
           "margin": {
               "l": 80,
               "r": 80,
               "t": 100,
               "b": 80,
               "pad": 0
           },
           "paper_bgcolor": "#f71122",
           "plot_bgcolor": "#ffffff",
           "showlegend": true,
           "title": "Scatter Plot",
           "titlefont": {
               "family": "Arial",
               "size": 15,
               "color": "#000000"
           },
           "hovermode": "closest",
           "xaxis": {
               "visible": true,
               "title": "xylulose NIST",
               "titlefont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#000000"
               },
               "autorange": false,
               "type": "linear",
               "xaxis_range_min": 80.55081,
               "xaxis_range_max": 1427.4781400000002,
               "range": [
                   -0.02607,
                   0.06556000000000001
               ],
               "tickmode": "auto",
               "nticks": 6,
               "tickvals": "[]",
               "ticktext": "[]",
               "ticks": "inside",
               "ticklen": 5,
               "tickwidth": 1,
               "tickcolor": "#000000",
               "showticklabels": true,
               "tickfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#000000"
               },
               "tickangle": 0,
               "showline": true,
               "linecolor": "#000000",
               "linewidth": 1,
               "showgrid": false,
               "gridcolor": "#eeeeee",
               "gridwidth": 1,
               "zeroline": false,
               "zerolinecolor": "#444444",
               "zerolinewidth": 1,
               "side": "bottom"
           },
           "yaxis": {
               "visible": true,
               "title": "xylose",
               "titlefont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#000000"
               },
               "autorange": false,
               "type": "linear",
               "yaxis_range_min": -1348.5849300000002,
               "yaxis_range_max": 15173.29319,
               "range": [
                   0.018090000000000002,
                   0.16126000000000001
               ],
               "tickmode": "auto",
               "nticks": 6,
               "tickvals": "[]",
               "ticktext": "[]",
               "ticks": "inside",
               "ticklen": 5,
               "tickwidth": 1,
               "tickcolor": "#000000",
               "showticklabels": true,
               "tickfont": {
                   "family": "Arial",
                   "size": 12,
                   "color": "#000000"
               },
               "tickangle": 0,
               "showline": true,
               "linecolor": "#000000",
               "linewidth": 1,
               "showgrid": true,
               "gridcolor": "#eeeeee",
               "gridwidth": 1,
               "zeroline": false,
               "zerolinecolor": "#444444",
               "zerolinewidth": 1,
               "side": "left"
           },
           "legend": {
               "borderwidth": 2,
               "font_open": false,
               "font": {
                   "family": "Arial",
                   "size": 12
               },
               "orientation": "v",
               "tracegroupgap": 10,
               "x": 1.02,
               "y": 1,
               "xanchor": "left",
               "yanchor": "top"
           }
       },
                    "saved_plot_data_ellipse":[
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "show_ellipse": true,
               "legendgroup": "",
               "name": "",
               "mode": "lines",
               "fill": "tozeroy",
               "plot_data_ellipse_fillcolor": "#ff69b4",
               "plot_data_ellipse_fillcolor_opacity": 1,
               "fillcolor": "rgba(255,105,180,1)",
               "opacity": 0.3,
               "line": {
                   "width": 1,
                   "color": "#ff69b4"
               },
               "showlegend": true,
               "uid": "544500",
               "$$hashKey": "object:2970"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "show_ellipse": true,
               "legendgroup": "",
               "name": "",
               "mode": "lines",
               "fill": "toself",
               "plot_data_ellipse_fillcolor": "#ff69b4",
               "plot_data_ellipse_fillcolor_opacity": 0.3,
               "fillcolor": "rgba(255,105,180,0.3)",
               "opacity": 0.3,
               "line": {
                   "width": 1,
                   "color": "#ff69b4"
               },
               "showlegend": true,
               "uid": "719ea7",
               "$$hashKey": "object:538"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "show_ellipse": true,
               "legendgroup": "",
               "name": "",
               "mode": "lines",
               "fill": "toself",
               "plot_data_ellipse_fillcolor": "#ff69b4",
               "plot_data_ellipse_fillcolor_opacity": 0.3,
               "fillcolor": "rgba(255,105,180,0.3)",
               "opacity": 0.3,
               "line": {
                   "width": 1,
                   "color": "#ff69b4"
               },
               "showlegend": true,
               "uid": "a9ed77",
               "$$hashKey": "object:539"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "show_ellipse": true,
               "legendgroup": "",
               "name": "",
               "mode": "lines",
               "fill": "toself",
               "plot_data_ellipse_fillcolor": "#ff69b4",
               "plot_data_ellipse_fillcolor_opacity": 0.3,
               "fillcolor": "rgba(255,105,180,0.3)",
               "opacity": 0.3,
               "line": {
                   "width": 1,
                   "color": "#ff69b4"
               },
               "showlegend": true,
               "uid": "73da68",
               "$$hashKey": "object:540"
           },
           {
               "x": [
               ],
               "y": [
               ],
               "type": "scatter",
               "show_ellipse": true,
               "legendgroup": "",
               "name": "",
               "mode": "lines",
               "fill": "toself",
               "plot_data_ellipse_fillcolor": "#ff69b4",
               "plot_data_ellipse_fillcolor_opacity": 0.3,
               "fillcolor": "rgba(255,105,180,0.3)",
               "opacity": 0.3,
               "line": {
                   "width": 1,
                   "color": "#ff69b4"
               },
               "showlegend": true,
               "uid": "c6d114",
               "$$hashKey": "object:541"
           }
       ]
                  }

                  db_user_info.put(new_user).then(function(){
                    localStorage.setItem("username", "AUTO_CREATED_USER_68410298_"+date_num)
                  }).then(function(){
                    $window.location.href = '/ocpu/library/Abib.alpha/www/#/content/project_list';
                  })
        }else{
          $window.location.href = '/ocpu/library/Abib.alpha/www/#/content/project_list';
        }
      }
      $scope.subscribe_prompt = function(ev) {
        var confirm = $mdDialog.prompt()
        .title('Would you like to recieve news from Met-DA?')
        .textContent("Enter an emaile address. We'll keep you updated about the development of Met-DA.")
        .placeholder('Email address')
        .targetEvent(ev)
        .required(true)
        .ok('Subscribe!')
        .cancel('Maybe next time.');

       $mdDialog.show(confirm).then(function(result) {
         var d = new Date();
         var num_date = d.getTime();
         var new_subscriber = {"_id":"Subscribed: "+num_date,email:result}
         var db_subscribe = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_subscribe');
         db_subscribe.put(new_subscriber).then(function(){
           $mdToast.show(
             $mdToast.simple()
               .textContent('Email address:'+result+' subscribed!')
               .position('bottom right')
               .hideDelay(3000)
           );
         })
        }, function() {
           $mdToast.show(
              $mdToast.simple()
                .textContent('canceled.')
                .position('bottom right' )
                .hideDelay(1000)
            );
        });
      }

    })
    .controller("navigation_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){


      $rootScope.$on("refresh_recommanded_hypothesis_tests",function(){
        $scope.refresh_recommanded_hypothesis_test();
      })
      $scope.refresh_recommanded_hypothesis_test = function(){
        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
         db.get(localStorage.getItem("project_id_global"), {attachments: false}).then(function(doc){
           if(typeof(doc.study_design)=='string'){// one way tests
             if(doc.sample_info_length[doc.study_design]==2){
               if(doc.study_design_type1 == 'independent'){
                 $scope.recommanded_hypothesis_tests = ['t test','nonparametric t test']
               }else{
                 $scope.recommanded_hypothesis_tests = ['paired t test','nonparametric paired t test']
               }
             }else{
               if(doc.study_design_type1 == 'independent'){
                 $scope.recommanded_hypothesis_tests = ['ANOVA','nonparametric ANOVA']
               }else{
                 $scope.recommanded_hypothesis_tests = ['repeated ANOVA','nonparametric repeated ANOVA']
               }
             }
           }else{// two way tests
             if(doc.study_design_type1 == 'independent' && doc.study_design_type2 == 'independent'){
               $scope.recommanded_hypothesis_tests = ['two way ANOVA']
             }else if(doc.study_design_type1 == 'repeated' && doc.study_design_type2 == 'repeated'){
               $scope.recommanded_hypothesis_tests = ['two way repeated ANOVA']
             }else{
               $scope.recommanded_hypothesis_tests = ['two way mixed ANOVA']
             }
           }
           console.log($scope.recommanded_hypothesis_tests)
         })
      }
      $scope.refresh_recommanded_hypothesis_test();





    })
    .controller("topnavbar_controller", function($scope, project_id_global_change_service,$mdDialog){

      $scope.open_tutorial_option = function($mdMenu,ev){
        $mdMenu.open(ev)
      }
      /*$scope.close_tutorial_option = function($mdMenu,ev){
        $mdMenu.close(ev)
      }*/
      $scope.open_tutorial_for_this_page = function(module_name){
        mmm = module_name
        /*$mdDialog.show({
          templateUrl: '/ocpu/library/Abib.alpha/www/views/landing_page.html',
          parent: angular.element(document.body),
          clickOutsideToClose:true,
          fullscreen: true
        })*/
        window.open("/ocpu/library/Abib.alpha/www/views/tutorials/"+module_name+".html");
      }


      $scope.project_id_global = project_id_global_change_service.get_project_id();
      $scope.$watch(project_id_global_change_service.get_project_id, function(v){
        console.log(v)
        $scope.project_id_global = v
        $scope.selected_project_name = v.split("_68410298")[0]
      })



    })
    .controller("right_sidebar_controller",function($rootScope,$scope, $uibModal, project_id_global_change_service , upload_tree_trigger_service, $mdDialog){
      // confirm deleting.
      $scope.delete_node_confirm = function(project_id) {
          // Appending dialog to document.body to cover sidenav in docs app
          var confirm = $mdDialog.confirm()
                .title('Would you like to delete this file?')
                .textContent('All of the banks have agreed to forgive you your debts.')
                .ariaLabel('Lucky day')
                .ok('Yes, delete it!')
                .cancel('No, cancel it.');

          $mdDialog.show(confirm).then(function() {
              var selected_node_id = $("#jstree").jstree("get_selected")
              var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
              db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){


                var remove_index = [];
                var bad_id = [];
                bad_id.push(selected_node_id[0])
                var saved_index; // see bad_id.splice(bad_id.indexOf(doc.tree_structure[i].id),1)
                  for(var i=0;i<doc.tree_structure.length;i++){

                  if(bad_id.indexOf(doc.tree_structure[i].id) > -1){// is the node is a bamakeProjectListTableHTMLd id, remove this node.
                    remove_index.push(i)
                    saved_index = doc.tree_structure[i].id
                  }
                  if(bad_id.indexOf(doc.tree_structure[i].parent)>-1){
                    remove_index.push(i)
                    bad_id.push(doc.tree_structure[i].id)
                  }
                }
                for(var i = remove_index.length -1;i>-1;i--){

                  if(doc.tree_structure[remove_index[i]].attname !== undefined){ // delete attachment as well
                    delete doc._attachments[[doc.tree_structure[remove_index[i]].attname]]
                  }
                  doc.tree_structure.splice(remove_index[i],1)
                }


                db.put(doc).then(function(){$scope.load_tree(project_id); });
              })
          }, function() {
            console.log("Didn't delete.")
          });
        };
      $scope.load_tree = function(project_id){
        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        $('#jstree').jstree('destroy');
              db.get(project_id).then(function(doc){
                $scope.$apply(function(){
                  $scope.num_sample = doc.sample_info.label.length
                  $scope.num_metabolite = doc.compound_info.label.length
                })

                  $('#jstree').jstree({
                        'core' : {
                          'data' : doc.tree_structure,
                              'check_callback' : function (operation, node, node_parent, node_position, more) {
                              // operation can be 'create_node', 'rename_node', 'delete_node', 'move_node', 'copy_node' or 'edit'
                              // in case of 'rename_node' node_position is filled with the new node name
                              return operation === 'rename_node' ? true : false;
                          },
                          'multiple':false, // cannot select multiple nodes.
                          'expand_selected_onload':true,
                           "check_callback" : true
                       },
                      "contextmenu":{ // content when user right click a node.
                        "show_at_node":false, // the menu follows the mouse.
                        "items":function($node) {

                          clicked_node = $node

                          var createable = false;
                          var renameable = true;
                          var removeable = true;
                          var uploadable = false;
                          var updateable = true;
                          var downloadable = true;
                          var loadable = false;
                          if($node.parent == '#'){
                            renameable = false;
                            removeable = false;
                          }
                          if($node.icon == "fa fa-folder"){
                              uploadable = true;
                              updateable = false;
                              createable = true;
                          }
                          if($node.icon == "fa fa-file-powerpoint-o"){
                              updateable = false;
                          }
                          if($node.icon !== "fa fa-file-powerpoint-o" && $node.icon !== "fa fa-folder" && $node.text.indexOf(".xlsx") !== -1){
                            updateable = false;
                          }
                          if($node.text === "sample_info.csv" && $node.parent === "root" || $node.text === "metabolite_info.csv"&& $node.parent === "root" || $node.text === "expression_data.csv"&& $node.parent === "root"){
                            renameable = false;
                            removeable = false;
                          }
                          sourceable = true;





                          var tree = $("#jstree").jstree(true);
                          var items = {
                              "Create": {
                                  "label": "Create Folder",
                                  "icon":"fa fa-plus-square-o",
                                  "_disabled":!createable,
                                  "action": function (obj) {
                                    $node = tree.create_node($node);
                                    tree.edit($node, null, function(node){// check if the node's new name has been taken. If so, delete this node. Otherwise, create a new node, with id 'newname'+Data().
                                      db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                                      db.get(project_id).then(function(doc){
                                        var nd = node;
                                        var sibling_id = tree.get_node(nd.parent).children
                                        var sibling_name = [];
                                        for(var i=0;i<sibling_id.length;i++){
                                          sibling_name.push(sibling_id[i].split("_68410298_")[0])
                                        }
                                        if(sibling_name.indexOf(nd.text) > -1){
                                          tree.delete_node(node);
                                          alert("The name, '"+nd.text+"' has been taken.")
                                        }else{
                                          var d = new Date();
                                          var num_date = d.getTime();
                                          doc.tree_structure.push({
                                            "id":nd.text+"_68410298_"+num_date,
                                            "parent":nd.parent,"text":nd.text,
                                            "icon":"fa fa-folder"
                                          })
                                          // reload the tree.
                                          var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');db.put(doc).then(function(){$scope.load_tree(project_id);});
                                        }
                                      }).catch(function (error) {
                                            console.log(error)
                                        });
                                    });

                                  }
                              },
                              "Rename": {
                                  "label": "Rename",
                                  "icon":"fa fa-edit",
                                  "_disabled": !renameable,
                                  "action": function (obj) {

                                    tree.edit($node, null, function(node){
                                      var old_node = $node

                                      db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                                      db.get(project_id).then(function(doc){
                                        var nd = node;
                                        var sibling_id = tree.get_node(nd.parent).children
                                        var sibling_name = [];
                                        for(var i=0;i<sibling_id.length;i++){
                                          sibling_name.push(sibling_id[i].split("_68410298_")[0])
                                        }
                                        if(sibling_name.indexOf(nd.text) > -1){
                                          alert(nd.text + " is taken!")
                                          $('#jstree').jstree(true).rename_node($('#jstree').jstree('get_selected'), old_node.id.split("_68410298_")[0]);
                                        }else{

                                          // change ID of old node.
                                          // change parent of old node children.
                                          var d = new Date();
                                          var num_date = d.getTime();
                                          var new_id = nd.text+"_68410298_"+num_date
                                          // delett the old node.
                                          for(var i=0;i<doc.tree_structure.length;i++){
                                            if(doc.tree_structure[i].id === old_node.id && doc.tree_structure[i].parent === old_node.parent){
                                              var old_tree_info = doc.tree_structure[i]
                                              doc.tree_structure.splice(i,1); break
                                            }
                                          }
                                          // add siblings with new id.
                                          for(var i=0;i<doc.tree_structure.length;i++){
                                            if(doc.tree_structure[i].parent === old_node.id){
                                              doc.tree_structure[i].parent = new_id
                                            }
                                          }
                                          // new id as parent.
                                          doc.tree_structure.push({
                                            "id":new_id,
                                            "parent":nd.parent,
                                            "text":nd.text,
                                            "icon":old_tree_info.icon,
                                            "source":old_tree_info.source,
                                            "attname":old_tree_info.attname,
                                            "column_name":old_tree_info.column_name,
                                            "column_length":old_tree_info.column_length,
                                            "column_class":old_tree_info.column_class,
                                            "column_value":old_tree_info.column_value,
                                          })
                                          var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');db.put(doc).then(function(){$scope.load_tree(project_id);});
                                        }
                                      }).catch(function (error) {
                                            console.log(error)
                                        });
                                    });
                                  }
                              },
                              "Remove": {
                                  "label": "Remove",
                                  "icon":"fa fa-trash-o",
                                  "_disabled":!removeable,
                                  "action": function (obj) {
                                      $scope.delete_node_confirm(project_id)
                                      // confirm_delete_node
                                  }
                              },
                              "Download":{
                                 "label": "Download",
                                 "icon":"fa fa-download",
                                "_disabled":!downloadable,
                                "action":function(obj){

                                  // download the file.
                                  if($node.id.indexOf("_csv") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_csv",".csv"))
                                  }else if($node.id.indexOf("_xlsx") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_xlsx",".xlsx"))
                                  }else if($node.id.indexOf("_pptx") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_pptx",".pptx"))
                                  }else if($node.id.indexOf("_png") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_png",".png"))
                                  }else if($node.id.indexOf("_svg") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_svg",".svg"))
                                  }else if($node.id.indexOf("_html") !== -1){
                                    window.open("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+project_id+"/"+$node.id.replace("_html",".html"))
                                  }else{ // this means that the node is a folder.
                                  var tree = $('#jstree').jstree(true);
                                  var selected_node_id = clicked_node.id;
                                  var unincluded_folder = [];
                                  var included_path = [];
                                  var included_id = [];
                                  included_path[0] = tree.get_path(tree.get_node(selected_node_id).id,"/")
                                  included_id[0] = selected_node_id
                                  unincluded_folder[0] = tree.get_node(selected_node_id).id;
                                  while(unincluded_folder.length > 0){
                                    var update_unincluded_folder = [];
                                    for(var i=0;i<unincluded_folder.length;i++){
                                      //var children = tree.get_children_dom(tree.get_node(unincluded_folder[i]))
                                      var children = tree.get_node(unincluded_folder[i]).children
                                      for(var j=0;j<children.length;j++){
                                        var child_node = tree.get_node(children[j])
                                        if(tree.is_leaf(child_node,"/")){
                                          included_id.push(child_node.id)
                                          included_path.push(tree.get_path(child_node,"/"))
                                        }else{
                                          included_id.push(child_node.id)
                                          included_path.push(tree.get_path(child_node,"/"))
                                          update_unincluded_folder.push(child_node.id)
                                        }
                                      }
                                    }
                                    unincluded_folder = update_unincluded_folder
                                  }

                                  iii = included_id
                                  ppp = included_path

                                  var req = ocpu.call("download_folder_as_zip",{
                                    project_id:localStorage.getItem("project_id_global"),
                                    id:included_id,
                                    path:included_path
                                  }, function(session){
                                    session.getObject(function(oo){
                                        window.open(session.loc + "files/" + oo[0])
                                    })
                                  }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
                                  }


                                }
                              },
                              "Source":{
                                "label": "View source",
                                "icon":"fa fa-eye",
                                "_disabled":!sourceable,
                                "action":function(obj){
                                  var selected_node_id = $('#jstree').jstree('get_selected')[0]
                                  var db = new PouchDB("http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib")
                                  db.get(localStorage.getItem("project_id_global"), {attachments: false}).then(function(doc){
                                    ooo = doc
                                    for(var i = 0; i<doc.tree_structure.length; i++){
                                      if(doc.tree_structure[i].id === selected_node_id){
                                        desired_node = doc.tree_structure[i]; break;
                                      }
                                    }
                                    $("#view_source_function_used").text(desired_node.source.FUNCTION)
                                    var parameter_html = ""
                                    var desired_node_keys = Object.keys(desired_node.source.PARAMETER)
                                    for(var i=0; i<desired_node_keys.length;i++){
                                      if(typeof(desired_node.source.PARAMETER[desired_node_keys[i]]) == "object" && !Array.isArray(desired_node.source.PARAMETER[desired_node_keys[i]])){// for some reason, their is phniotype_data, etc that is not the parameter of R function. Get rid of them by checking the type.

                                      }else if(Array.isArray(desired_node.source.PARAMETER[desired_node_keys[i]])){// if this is array, join them with ', '
                                      parameter_html = parameter_html + '<li><b>' + desired_node_keys[i] + ':</b> ' + desired_node.source.PARAMETER[desired_node_keys[i]].join(", ")

                                      }else if(typeof(desired_node.source.PARAMETER[desired_node_keys[i]]) === "string"){
                                        parameter_html = parameter_html + '<li><b>' + desired_node_keys[i] + ':</b> ' + desired_node.source.PARAMETER[desired_node_keys[i]].split("_68410298_")[0]
                                      }
                                    }

                                    $("#view_source_parameter_used").html(parameter_html)


                                    $('#view_source_modal').modal('show');


                                  })
                                }
                              }
                              /*,"Load":{
                                 "label": "Load result",
                                 "icon":"fa fa-edit",
                                "_disabled":!loadable,
                                "action":function(obj){
                                  split(" | ")[1]
                                }
                              }*/
                          };
                          return items;
                      }
                      },
                       "plugins" : [  "contextmenu",  "state"]

                       })
      }).catch(function (err) {
        console.log(err);
      });
      }
      $scope.project_id_global = project_id_global_change_service.get_project_id();
      $scope.$watch(project_id_global_change_service.get_project_id, function(v){
        $scope.project_id_global = v
        $scope.selected_project_name = v.split("_68410298")[0]
        // update the tree structure
        $scope.load_tree(v)
      })
      $scope.$watch(upload_tree_trigger_service.get_update_tree_trigger, function(){
        $scope.load_tree(localStorage.getItem("project_id_global"))
      })

      $rootScope.$on('update_tree', function(event, args) {
        $scope.load_tree(args)
      });





      /*$scope.selected_project_name = localStorage.getItem("project_id_global").split("_68410298")[0]
      $scope.$on('selected_project_name', function (event, arg) {
        $scope.selected_project_name = arg;
        // can be used to update the tree. $scope.$watch('selected_project_name', function () {alert("!")})
        // define the tree structure

      });*/


    })
    .controller('project_list_controller', function($rootScope,$scope,$window, $uibModal, toaster, project_id_global_change_service) {
      $scope.test = function(){
        $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
      }


      $scope.no_project = false;
      $scope.have_project = false;
      $scope.project_id_global = project_id_global_change_service.get_project_id();
      $scope.$watch(project_id_global_change_service.get_project_id, function(v){
        $scope.project_id_global = v
        $scope.selected_project_name = v.split("_68410298")[0]
      })
      /*$scope.selected_project_name = localStorage.getItem("project_id_global").split("_68410298")[0]
      $scope.$on('selected_project_name', function (event, arg) {
        $scope.selected_project_name = arg;
      });*/

     var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');
     var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
     db_user_info.get(localStorage.getItem("username")).then(function(doc){
       var projects;
       $scope.$apply(function(){
          projects = doc.project_list
          $scope.projects = projects
          $scope.create_new_project = function(){
            $window.location.href = '/ocpu/library/Abib.alpha/www/#/content/new_project';
          }
          if(projects.length === 0){
            $scope.no_project = true;
          }else{
            $scope.have_project = true;
          }
       })

       $scope.delete_project_confirmation_modal = function (index){
        var modalInstance = $uibModal.open({
            templateUrl: 'views/delete_project_confirmation_modal.html',
            size: 'md',
            controller: function($rootScope,$scope, $uibModalInstance, project_id_global_change_service){
              $scope.confirm_text = "Yes, delete it."
              $scope.disabel_confirm_button = false;
              $scope.project_name = projects[index].project_name

                  $scope.ok = function () {
                    $scope.confirm_text = "Deleting..."
                    $scope.disabel_confirm_button = true;
                    var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                    var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');

                    db_user_info.get(localStorage.getItem("username")).then(function(doc_user_info){

                      for(var i=0; i<doc_user_info.project_list.length;i++){
                        if(doc_user_info.project_list[i].project_name === $scope.project_name){
                          var deleting_project_id = doc_user_info.project_list[i].id
                          doc_user_info.project_list.splice(i,1);break;
                        }
                      }
                      db_user_info.put(doc_user_info)
                      return(deleting_project_id)
                    }).then(function(deleting_project_id){
                        if(localStorage.getItem('project_id_global') == deleting_project_id){
                          project_id_global_change_service.set_project_id("")
                          localStorage.removeItem('project_id_global')
                          localStorage.setItem('activated_data_id', null)
                          localStorage.setItem('activated_data_text', null)
                        }
                      db.get(deleting_project_id).then(function(doc){
                        var d = new Date()
                        doc.deleted = "deleted at "+ d
                        return(doc)
                      }).then(function(doc){
                        db.put(doc);
                        $scope.confirm_text = "Yes, delete it."
                        $scope.disabel_confirm_button = false;
                        location.reload();
                      })
                    }).catch(function (err) {
                        console.log(err);
                    });


                  };

                  $scope.cancel = function () {
                      $uibModalInstance.dismiss('cancel');
                  };
            }
       });
    };
       $scope.select_project = function(index){
          db_user_info.get(localStorage.getItem("username")).then(function(doc_user_info){
            var selected_project = doc_user_info.project_list[index]
            $scope.$apply(function(){
              project_id_global_change_service.set_project_id(selected_project.id)
            })
            // go to view project page and user could start analysis.
            $window.location.href = '/ocpu/library/Abib.alpha/www/#/content/view_project';
          })


       }

     }).catch(function (e) {
       console.log(e.error)
      if(e.error== 'not_found'){
            localStorage.clear();
      var ip;
      $.get("http://ipinfo.io", function(response) {ip = response.ip;
            var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');

            var date = new Date();
            var date_num = date.getTime();


             var new_user = {
                    "_id":"AUTO_CREATED_USER_68410298_"+date_num,
                    "password":"",
                    "email":"",
                    "project_list":[],
                    "ip_address":[ip + "_68410298_" + date],
                    "create_time":date,
                    "saved_plot_data":[],
                    "saved_plot_layout":[],
                    "saved_plot_data_ellipse":[]
                  }

                  db_user_info.put(new_user).then(function(){
                    localStorage.setItem("username", "AUTO_CREATED_USER_68410298_"+date_num)
                  }).then(function(){
                    location.reload();
                  })
      }, "jsonp");

      }

    });

    })
    .controller("view_project_controller", function($scope, $rootScope){
      $rootScope.$emit("refresh_recommanded_hypothesis_tests", {});
      // make table with pure javascript.
      makeInfoTableHTML = function(myArray) {
  			var headers = Object.keys(myArray[0])
  			var result = "<table class='table table-hover animated fadeInUp' style='font-size:medium;font-size: x-small;'><thead>";
  			// headers
  			for(var h=0; h<headers.length;h++){// +1 means to add the 'select button'
  			    result = result + "<th>"+ headers[h] + "</th>";
  			  }
  			result = result+"</thead><tbody>"
  			for(var i=0; i<myArray.length; i++) {
  				 result += "<tr>";
    			for(var j=0; j<headers.length; j++){// +1 means to add the 'select button'
    			 result += "<td>"+myArray[i][headers[j]]+"</td>";
    			}
  				result += "</tr>";
  			}
  			result += "</tbody></table>";
        return result;
      }
      $scope.project_name = localStorage.getItem("project_id_global").split("_68410298")[0]
      $scope.username = localStorage.getItem("username").split("_68410298")[0]
      $scope.num_of_views = 0
      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
      db.get(localStorage.getItem("project_id_global"),{attachments:false}).then(function(doc){
        ddd = doc
        $scope.created_time = doc.created_time.split("T").join(" ").split(".")[0]
        $scope.num_of_samples = doc.sample_info.label.length
        $scope.num_of_compounds = doc.compound_info.label.length
        if(typeof(doc.study_design)=='string'){
          $scope.study_design1 = doc.study_design
          $scope.study_design1_type = doc.study_design_type1
        }else{
          $scope.study_design1 = doc.study_design[0]
          $scope.study_design1_type = doc.study_design_type1
          $scope.study_design2 = doc.study_design[1]
          $scope.study_design2_type = doc.study_design_type2
        }
      $("#sample_info_table").html(makeInfoTableHTML(JSON.parse(doc.sample_info_table_JSON)));
      $("#compound_info_table").html(makeInfoTableHTML(JSON.parse(doc.compound_info_table_JSON)));
      }).then(function(){
         Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+localStorage.getItem("project_id_global").split("_68410298_")[1]+".csv", {header: true,download: true,complete: function(results) {p = results;

        p.data.pop();
        $scope.levels = unpack(p.data,$scope.study_design1).filter(unique)

      }});

      })

      // task list
      $.get('http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task/_design/project_task/_view/project_task?key="'+localStorage.getItem("project_id_global")+'"',function(data){
        var tasks = JSON.parse(data)
        aaa = tasks
        $scope.tasks = tasks
        $scope.num_task = tasks.rows.length
      })

//http://chemrichdb2.fiehnlab.ucdavis.edu:5985/_utils/database.html?abib_task/_design/task_project/_view/task_project

      // generate workflow view
        var req = ocpu.call("view_project_workflow",{
          project_ID:localStorage.getItem("project_id_global")
        },function(session){
          $('#show_workflow').attr('src', session.loc + "files/workflow.html");
        })

      // report related
      var req = ocpu.call("generate_report_text",{
        project_ID:localStorage.getItem("project_id_global")
      },function(session){
        session.getObject(function(obj){
          $("#report_editor").val(obj[0])
          $("#report_editor").markdown({
              autofocus:false,savable:true,fullscreen:{enable:false},
              onSave: function(e) {
                var req  = ocpu.call("generate_report",{
                  project_ID:localStorage.getItem("project_id_global"),
                  input:e.getContent()
                },function(session){
                  window.open(session.loc + "files/report-"+localStorage.getItem("project_id_global").split("_68410298")[0].replace(" ", "_")+".docx")
                })
              }
            })
        })
      })


      // auto analysis
      // missing value
      $scope.editing_missing_value = false
      $scope.missing_value_define_options = [{
          text:"empty cells",
          value:'empty cell'
        },{
          text:"zeros",
          value:"zero"
        },{
          text:"negative values",
          value:"negative value"
        }]
      $scope.missing_value_define = "empty cell"
      $scope.missing_value_imputation_method_options = ["half minimum","minimum","median","one"]
      $scope.missing_value_imputation_method = "half minimum"

      // data processing
      $scope.editing_data_processing = false
      $scope.sample_normalization_method_options = [{
        text:"normalization by sum",
        value:"sum"
      },{
        text:"normalization by median",
        value:"median"
      },{
        text:"normalization by mean",
        value:"mean"
      },{
        text:"quantile normalization",
        value:"quantile"
      },{
        text:"no normalization",
        value:"none"
      }]
      $scope.sample_normalization_method = "none"
      $scope.data_transformation_method_options = [{
        text:"generalized log10 transformation",
        value:"log10"
      },{
        text:"generalized log2 transformation",
        value:"log2"
      },{
        text:"square root",
        value:"square root"
      },{
        text:"cubic root",
        value:"cubic root"
      },{
        text:"none",
        value:"none"
      },{
        text:"auto select based on normality",
        value:"auto"
      }]
      $scope.data_transformation_method = "auto"
      $scope.data_scaling_method_options = [{
        text:"auto scaling",
        value:"auto"
      },{
        text:"pareto scaling",
        value:"pareto"
      },{
        text:"centering with no scaling",
        value:"center"
      },{
        text:"no scaling",
        value:"none"
      }]
      $scope.data_scaling_method = "pareto"

      // descriptive statistics
      $scope.mean_des = true; $scope.median_des = true; $scope.sd_des = true; $scope.num_outlier_des = true;$scope.fold_change_des = true;
      // multivariate analysis
      //pca
      $scope.editing_pca = false
      $scope.algoC_options = [{value:"svd",text:"Singular-value decomposition"},{value:"nipals",text:"NonLinear Iterative Partial Least Squares"}]
      $scope.algoC = "svd"
      $scope.num_PC_PCA_options = ["2","3","4","5","6","7","8","9","10"]
      $scope.num_PC_PCA = "5"
      //plsda
      $scope.editing_plsda = false
      $scope.algoC_plsda_options = [{value:"svd",text:"Singular-value decomposition"},{value:"nipals",text:"NonLinear Iterative Partial Least Squares"}]
      $scope.algoC_plsda = "nipals"
      $scope.num_PC_PLSDA_options = ["2","3","4","5","6","7","8","9","10"]
      $scope.num_PC_PLSDA = "5"
      $scope.num_perm_PLSDA = 100

      // visualization
      $scope.boxplot_vis = true;
      $scope.histogram_vis = true;
      $scope.barplot_vis = true;



    })
    .controller('create_new_project_controller', function($rootScope, $scope, $http, DTOptionsBuilder, DTColumnBuilder,$window, project_id_global_change_service){
      $scope.download_example_file = function(){
        window.open("https://github.com/slfan2013/Abib.alpha/raw/master/example%20data.xlsx")
      }
      $scope.see_file_requirement = function(){
        console.log("!")
        window.open("/ocpu/library/Abib.alpha/www/views/tutorials/new_project/Slide2.PNG")
      }
      // limit number of study design selection to 2
      $scope.limit_study_design_to_2 = function(val) {
         if(val && val.length > 2) {
           $scope.multiple.new_project_study_design = $scope.prevModel;
         } else {
           $scope.prevModel = val;
         }
      }

      $scope.submit_button_html = "Submit" // submit button html. will change to spin when submitting.
      $scope.being_submitted = false // controll the disable of the submit button.
      var data_sample_info;
      var data_path;
        // when user select a file, automatically upload it, and show a spin at the same time.
        $scope.uploadFile = function(){
          data_path = event.target.files[0]
            var req = ocpu.call("upload_data",{
              path:data_path
            }, function(session){
              session.getObject(function(obj){
                $scope.$apply(function(){
                  $scope.warning_message = obj["warning_message"] // display warning message.

                  $scope.preview = function(){
                    $scope.show_preview = true // show the preview data.
                  }

                  $scope.dtOptions_sample_info = DTOptionsBuilder.fromSource(session.loc + "files/sample_info.JSON")
                          .withPaginationType('full_numbers')
                          .withDOM('<"html5buttons"B>lTfgitp')
                          .withOption('order', [])
                          .withButtons([
                              {extend: 'csv'},
                              {extend: 'excel', title: 'sample_info'}
                          ]);;
                  var dtColumns_sample_info = [];
                  for(var i=0; i<obj["colnames_sample_info"].length; i++){
                    dtColumns_sample_info.push(DTColumnBuilder.newColumn(obj["colnames_sample_info"][i]).withTitle(obj["colnames_sample_info"][i]).withOption('width', '10%'))
                  }
                  $scope.dtColumns_sample_info = dtColumns_sample_info

                  $scope.dtOptions_metabolite_info = DTOptionsBuilder.fromSource(session.loc + "files/metabolite_info.JSON")
                          .withPaginationType('full_numbers')
                          .withDOM('<"html5buttons"B>lTfgitp')
                          .withOption('order', [])
                          .withButtons([
                              {extend: 'csv'},
                              {extend: 'excel', title: 'metabolite_info'}
                          ]);;
                  var dtColumns_metabolite_info = [];
                  for(var i=0; i<obj["colnames_metabolite_info"].length; i++){
                    dtColumns_metabolite_info.push(DTColumnBuilder.newColumn(obj["colnames_metabolite_info"][i]).withTitle(obj["colnames_metabolite_info"][i]).withOption('width', '10%').withOption('defaultContent', ' '))
                  }
                  $scope.dtColumns_metabolite_info = dtColumns_metabolite_info
                  // for study design
                  $scope.multiple = {};
                  $scope.multiple.new_project_study_design = obj["guess_study_design"];
                  $scope.available_new_project_study_designs = obj["colnames_sample_info"];
                  $scope.sample_id_options = obj["colnames_sample_info"]
                })
              })
            }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
        };
        $scope.submit = function(){
          $scope.submit_button_html = '<i class="fa fa-spinner fa-spin"></i>'
          $scope.being_submitted = true
          if($scope.multiple.new_project_study_design.length == 0){ // check if user has selected study design
            alert("Please specify your study design (in the Study Design Factors).")
            $scope.submit_button_html = "Submit"
            $scope.being_submitted = false
            return false;
          }
          if(($scope.study_design_type1 == 'repeated' || $scope.study_design_type2 == 'repeated')&&$scope.sample_id == undefined){ // check if user has selected sample_id is the study design involved repeated measure.
            $scope.submit_button_html = "Submit"
            $scope.being_submitted = false
            alert("Because you've selected an repeated measure study design, you must specify a valid sample_id (in the sample id selection).")

            return false;
          }
          // check if username is taken.
          event.preventDefault()
          var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
          var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');

          db_user_info.get(localStorage.getItem("username")).then(function(doc){
            var project_list = doc.project_list
            return(project_list)
          }).then(function(project_list){
          var project_name = [];
          for(i = 0; i < project_list.length; i++){
            project_name.push(project_list[i].project_name)
          }

          if(project_name.indexOf($scope.new_project_name) > -1){
            $scope.submit_button_html = "Submit"
            $scope.being_submitted = false
            alert("The project name, "+$scope.new_project_name+", has been taken.")
            return false;
          }

          // everything is fine. Start creating the project.
          // create_new_project
          var req = ocpu.call("create_new_project",{
                              path:data_path
                            },function(session){
                              sss = session;
                                        //}).done(function(){
                                          sss.getObject(function(obj){
                                          if(obj.success){
                                            var d = new Date();
                                            var num_date = d.getTime();
                                            var project_id = $scope.new_project_name+"_68410298_"+num_date;
                                            // use pouchdb to create project, upload files and create tree structure.
                                            // put new project to couchdb, attach upload files, create tree structure, push to project_list, finish.
                                            new_project = {
                                              "_id":project_id,
                                              "created_time":d,
                                              "tree_structure":[
                                                {"id":"root","parent":"#","text":$scope.new_project_name,icon:"fa fa-folder", report:"Project: " + $scope.new_project_name+" report\n============\nthis is a paragraph."},
                                                {"id":"expression_data_68410298_"+num_date+"_csv","parent":"root","text":"expression_data.csv",icon:"fa fa-file-excel-o",attname:"expression_data_68410298_"+num_date+".csv",source:{FUNCTION:"create_new_project", PARAMETER:{
                                        path:data_path
                                      }}, source_node_id: "root", type:"data_set"},
                                                {"id":"metabolite_info_68410298_"+num_date+"_csv","parent":"root","text":"metabolite_info.csv",icon:"fa fa-file-excel-o",attname:"metabolite_info_68410298_"+num_date+".csv",source:{FUNCTION:"create_new_project", PARAMETER:{
                                        path:data_path
                                      }}, source_node_id: "root",column_name:obj.compound_info_column_name,column_length:obj.compound_info_length,column_class:obj.compound_info_class,column_value:obj.compound_info, type:"compound_related_result"},
                                                {"id":"sample_info_68410298_"+num_date+"_csv","parent":"root","text":"sample_info.csv",icon:"fa fa-file-excel-o",attname:"sample_info_68410298_"+num_date+".csv",source:{FUNCTION:"create_new_project", PARAMETER:{
                                        path:data_path
                                      }}, source_node_id: "root",column_name:obj.sample_info_column_name,column_length:obj.sample_info_length,column_class:obj.sample_info_class,column_value:obj.sample_info, type:"data_set", type:"sample_related_result"}
                                              ],
                                              "sample_info_column_name":obj.sample_info_column_name,
                                              "sample_info":obj.sample_info,
                                              "sample_info_length":obj.sample_info_length,
                                              "sample_info_class":obj.sample_info_class,



                                              "compound_info_column_name":obj.compound_info_column_name,
                                              "compound_info":obj.compound_info,
                                              "compound_info_length":obj.compound_info_length,
                                              "compound_info_class":obj.compound_info_class,

                                              "sample_info_table_JSON":obj.sample_info_table_JSON,
                                              "compound_info_table_JSON":obj.compound_info_table_JSON,

                                              "study_design":$scope.multiple.new_project_study_design,
                                              "study_design_type1":$scope.study_design_type1,
                                              "study_design_type2":$scope.study_design_type2,

                                              "sample_id":$scope.sample_id



                                            }
                                            db.put(new_project).then(function(){
                                              // use R to upload file.
                                              var req2 = ocpu.call("create_new_project_put_files",{
                                                path:data_path,
                                                project_ID:project_id,
                                                numeric_time:num_date
                                              },function(session2){})
                                              db_user_info.get(localStorage.getItem("username")).then(function(db_user_info_doc){
                                                var created_time = new Date();
                                                 db_user_info_doc.project_list.push({
                                                   "id":project_id,
                                                   "project_name":$scope.new_project_name,
                                                   "created_time":created_time,
                                                   "size":"1mb",
                                                   "status":"Owned"
                                                 });
                                                 db_user_info.put(db_user_info_doc)
                                                 //localStorage.setItem("project_id_global", project_id)
                                                 //$rootScope.$broadcast("selected_project_name",$scope.new_project_name)
                                                 //localStorage.setItem('activated_data_id', null)
                                                 //localStorage.setItem('activated_data_text', null)
                                                 project_id_global_change_service.set_project_id(project_id)
                                                 localStorage.setItem("activated_data_id", "expression_data_68410298_"+num_date+"_csv")
                                                 $window.location.href = '/ocpu/library/Abib.alpha/www/#/content/project_list';
                                              })
                                          })
                                          }
                                          })

                                      //})

        }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
        })

    }
    })
    .controller("hypothesisTestCtrl", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){



       /*$scope.subset_data_dialog = function(ev) {
          // Appending dialog to document.body to cover sidenav in docs app
          var confirm = $mdDialog.prompt()
            .title('What filename are you going to use for this subset data?')
            .textContent('Make name specific for the subseting, e.g. subset based on a vs b. No special character (/,.,etc) allowed!')
            .placeholder('filename')
            .ariaLabel('filename')
            .initialValue('subset based on ')
            .targetEvent(ev)
            .required(true)
            .ok('Create & Save!')
            .cancel('Nope, cancel it.');

          $mdDialog.show(confirm).then(function(result) {
            re = result
            var corrected_result = result.replace(",","_").replace(".","_")
            db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
              filename = get_filename_service.get_filename(doc,corrected_result,PARAMETER.expression_id)
              // check if subsetting the samples or compounds.
              table_data = $scope.table_data
              var cancidate_label = table_data.map(function(x){return x.label})
              var sample_label = Object.keys(e.data[0]);sample_label.splice(0,1)
              var compound_label = e.data.map(function(x){return x.label})
              if(cancidate_label.every(function(val) { return compound_label.indexOf(val) >= 0;})){// subsetting according to the compound (rows)
                var candidate_index = cancidate_label.map(function(x){return(compound_label.indexOf(x))})
                var subset = candidate_index.map(function(i){return e.data[i]})
              }else{ //!!! subset according to sample (columns).

              }
              var subset_csv =  Papa.unparse(subset);

              doc['_attachments'][corrected_result+"_68410298_"+time_string+".csv"] = {
                                      content_type:"application/vnd.ms-excel",
                                      "data": btoa(subset_csv)
                                    }


            })



          }, function() {

          });
        };*/

      $scope.plot_pie_graph = function(value = obj.out.graph_pie_data, table_data = obj.out.table_data, table_data_criterion = obj.out.table_data_criterion){
        vvv = value;
        ttt = table_data;
        ccc = table_data_criterion;

        $scope.selected_datas = []
        $scope.show_pie_chart = true;
        if($scope.pie_ready) {
      			pie.destroy();
      	}
      	$scope.pie_ready = true
      	$timeout(function(){
          pie = new d3pie("pie", {
              size: {
                      canvasHeight: 450,
                      canvasWidth: 450
                    },
          	data: {
          		content: value
          	},
          	callbacks: {
          		onClickSegment: function(a) {
          		  aaa = a
          			selected_criterion = a.data.label // raw significant or FDR significant or
          			//selected_criterion = selected_criterion.replace("not significant:","statistic:").replace("significant:","statistic:")
          			var selected_table_data = [];
          			var colors = [];
          			for(var i=0;i<table_data.length;i++){
          			  if(table_data_criterion[i][selected_criterion]){ // !!!.
          			    selected_table_data.push(table_data[i])
          			    if(selected_criterion.indexOf("significant:")==-1){
          			      colors.push((table_data[i][Object.keys(table_data[i])[1]]>0)?"green":"red")
          			    }else{
          			      colors.push((table_data[i][selected_criterion.replace("not significant:","statistic:").replace("significant:","statistic:")]>0)?"red":"green")
          			    }
          			  }
          			}
          			$scope.$apply(function(){
          			  $scope.selected_data_colors = colors
          			  $scope.table_data = selected_table_data
                  $scope.selected_datas = selected_table_data
          			})

          			sss = selected_table_data
          		}
          	}
          });
      	},10)

      }
      $scope.plot_heatmap = function(xValues = $scope.levels, yValues = $scope.levels, zValues = obj.out.heatmap_data, table_data = obj.out.table_data, table_data_criterion = obj.out.table_data_criterion, graph_pie_data_for_click = obj.out.graph_pie_data_for_click){
                        $scope.show_significancy_heatmap = true
                        //var xValues = $scope.levels;
                        xValues = xValues.map(function(e){
                          return e.replace(".","_")
                        })

                        //var yValues = $scope.levels
                        yValues = yValues.map(function(e){
                          return e.replace(".","_")
                        })

                        var colorscaleValue = [
                          [0, '#3D9970'],
                          [1, '#001f3f']
                        ];

                        var data = [{
                          x: xValues,
                          y: yValues,
                          z: zValues,
                          type: 'heatmap',
                          colorscale: colorscaleValue,
                          showscale: false
                        }];

                        var layout = {
                          title: 'Significancy Heatmap',
                          annotations: [],
                          xaxis: {
                            ticks: '',
                            side: 'top'
                          },
                          yaxis: {
                            ticks: '',
                            ticksuffix: ' ',
                            width: 700,
                            height: 700,
                            autosize: false
                          }
                        };

                        for ( var i = 0; i < yValues.length; i++ ) {
                          for ( var j = 0; j < xValues.length; j++ ) {
                            var currentValue = zValues[i][j];
                            if (currentValue != 0.0) {
                              var textColor = 'white';
                            }else{
                              var textColor = 'black';
                            }
                            var result = {
                              xref: 'x1',
                              yref: 'y1',
                              x: xValues[j],
                              y: yValues[i],
                              text: zValues[i][j],
                              font: {
                                family: 'Arial',
                                size: 12,
                                color: 'rgb(50, 171, 96)'
                              },
                              showarrow: false,
                              font: {
                                color: textColor
                              }
                            };
                            layout.annotations.push(result);
                          }
                        }

                        $timeout(function(){
                          Plotly.newPlot('significancy_heatmap', data, layout);
                          var myPlot = document.getElementById('significancy_heatmap')
                          myPlot.on('plotly_click', function(data){

                              ddd = data
                              var graph_pie_data = []
                              for(var i=0; i<graph_pie_data_for_click.length;i++){
                                if(graph_pie_data_for_click[i].label == "significant: "+data.points[0].x+" vs "+data.points[0].y){
                                  graph_pie_data.push({
                                    label : "significant: "+data.points[0].x+" vs "+data.points[0].y,
                                    value : graph_pie_data_for_click[i].value
                                  })
                                }else if(graph_pie_data_for_click[i].label == "not significant: "+data.points[0].x+" vs "+data.points[0].y){
                                  graph_pie_data.push({
                                    label : "not significant: "+data.points[0].x+" vs "+data.points[0].y,
                                    value : graph_pie_data_for_click[i].value
                                  })
                                }else if(graph_pie_data_for_click[i].label == "significant: "+data.points[0].y+" vs "+data.points[0].x){
                                  graph_pie_data.push({
                                    label : "significant: "+data.points[0].y+" vs "+data.points[0].x,
                                    value : graph_pie_data_for_click[i].value
                                  })
                                }else if(graph_pie_data_for_click[i].label == "not significant: "+data.points[0].y+" vs "+data.points[0].x){
                                  graph_pie_data.push({
                                    label : "not significant: "+data.points[0].y+" vs "+data.points[0].x,
                                    value : graph_pie_data_for_click[i].value
                                  })
                                }
                              }
                              $scope.plot_pie_graph(value = graph_pie_data, table_data = table_data, table_data_criterion = table_data_criterion)
                          });
                        },10)


                      }
      $scope.generate_two_way_boxplot = function(d = [trace1, trace2, trace3], label = row.label){
            var layout = {
              title:label,
              yaxis: {
                title: 'data value',
                zeroline: false
              },
              boxmode: 'group'
            };
            Plotly.newPlot('two_way_boxplot', d, layout);
        }
      $scope.calculating = false;
      $scope.refresh_all_options = function(){
          $scope.two_group = false;
		      $scope.show_two_way_boxplot = false;
		      $scope.show_venn = false;
        }
		  $scope.pie_ready = false
		  $scope.show_two_way_boxplot = false;
		  $scope.display_two_way_boxplot = function(){
		    $scope.show_two_way_boxplot = true;
		  }
		  $scope.show_venn = false;
		  $scope.display_venn = function(){
		    $scope.show_venn = true;
		  }
		  $scope.sphericity_correction = true;

      $scope.table_ready = false;
      $scope.table_options = {
        footerHeight: false,
        scrollbarV: true,
        headerHeight: 50,
        selectable: true,
        multiSelect: false,
        sortable:false,
        columnMode:"force",
        columns: [{
          name: "Name",
          prop: "name"
        }, {
          name: "Gender",
          prop: "gender"
        }, {
          name: "Company",
          prop: "company"
        }]
      };// for initializing the table.
      $http.get('js/100data.json').success(function(data) {
        $scope.table_data = data.splice(0, 10);
      });// for initializing the table.

      $scope.post_hoc_test_type_options = [{
        value:"Games_Howell_test",
        text:"Games Howell post hoc test"
      },{
        value:"tukey_test",
        text:"Tukey's range test"
      },{
        value:"pairwise_t_test_with_no_correction",
        text:"t test with no correction"
      },{
        value:"pairwise_t_test_with_fdr",
        text:"t test with Bonjamini-Hochberg correction (1995)"
      },{
        value:"pairwise_t_test_with_holm",
        text:"t test with Holm correction (1979)"
      },{
        value:"pairwise_t_test_with_hochberg",
        text:"t text with Hochberg correction (1988)"
      },{
        value:"pairwise_t_test_with_hommel",
        text:"t test with Hommel correction (1988)"
      },{
        value:"pairwise_t_test_with_bonferroni",
        text:"t test with Bonferroni correction (1936)"
      },{
        value:"pairwise_t_test_with_BH",
        text:"t test with Benjamini & Hochberg correction (1995)"
      },{
        value:"pairwise_t_test_with_BY",
        text:"t test with Benjamini & Yekutieli correction (2001)"
      }]

      $scope.nonparametric_post_hoc_test_type_options = [{
        value:"pairwise_nonparametric_t_test_with_no_correction",
        text:"Mann-Whitney U test with no correction"
      },{
        value:"pairwise_nonparametric_t_test_with_fdr",
        text:"Mann-Whitney U test with Bonjamini-Hochberg correction (1995)"
      },{
        value:"pairwise_nonparametric_t_test_with_holm",
        text:"Mann-Whitney U test with Holm correction (1979)"
      },{
        value:"pairwise_nonparametric_t_test_with_hochberg",
        text:"Mann-Whitney U test with Hochberg correction (1988)"
      },{
        value:"pairwise_nonparametric_t_test_with_hommel",
        text:"Mann-Whitney U test with Hommel correction (1988)"
      },{
        value:"pairwise_nonparametric_t_test_with_bonferroni",
        text:"Mann-Whitney U test with Bonferroni correction (1936)"
      },{
        value:"pairwise_nonparametric_t_test_with_BH",
        text:"Mann-Whitney U test with Benjamini & Hochberg correction (1995)"
      },{
        value:"pairwise_nonparametric_t_test_with_BY",
        text:"Mann-Whitney U test with Benjamini & Yekutieli correction (2001)"
      }]

      $scope.post_hoc_test_type_r_options = [{
        value:"pairwise_paired_t_test_with_no_correction",
        text:"paired t test with no correction"
      },{
        value:"pairwise_paired_t_test_with_fdr",
        text:"paired t test with Bonjamini-Hochberg correction (1995)"
      },{
        value:"pairwise_paired_t_test_with_holm",
        text:"paired t test with Holm correction (1979)"
      },{
        value:"pairwise_paired_t_test_with_hochberg",
        text:"paired t test with Hochberg correction (1988)"
      },{
        value:"pairwise_paired_t_test_with_hommel",
        text:"paired t test with Hommel correction (1988)"
      },{
        value:"pairwise_paired_t_test_with_bonferroni",
        text:"paired t test with Bonferroni correction (1936)"
      },{
        value:"pairwise_paired_t_test_with_BH",
        text:"paired t test with Benjamini & Hochberg correction (1995)"
      },{
        value:"pairwise_paired_t_test_with_BY",
        text:"paired t test with Benjamini & Yekutieli correction (2001)"
      }]

      $scope.nonparametric_post_hoc_test_type_r_options = [{
        value:"pairwise_nonparametric_paired_t_test_with_no_correction",
        text:"Wilcoxon signed-rank test with no correction"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_fdr",
        text:"Wilcoxon signed-rank test with Bonjamini-Hochberg correction (1995)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_holm",
        text:"Wilcoxon signed-rank test with Holm correction (1979)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_hochberg",
        text:"Wilcoxon signed-rank test with Hochberg correction (1988)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_hommel",
        text:"Wilcoxon signed-rank test with Hommel correction (1988)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_bonferroni",
        text:"Wilcoxon signed-rank test with Bonferroni correction (1936)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_BH",
        text:"Wilcoxon signed-rank test with Benjamini & Hochberg correction (1995)"
      },{
        value:"pairwise_nonparametric_paired_t_test_with_BY",
        text:"Wilcoxon signed-rank test with Benjamini & Yekutieli correction (2001)"
      }]

      $scope.post_hoc_test_type = "Games_Howell_test"
      $scope.nonparametric_post_hoc_test_type = "pairwise_nonparametric_t_test_with_holm"
      $scope.post_hoc_test_type_r = "pairwise_paired_t_test_with_holm"
      $scope.nonparametric_post_hoc_test_type_r = "pairwise_nonparametric_paired_t_test_with_holm"

      // control which shows which hide according to different module.
        $scope.two_group = false;
        $scope.change_two_group = function() {
          $scope.two_group = true;
        };
        $scope.hide_expression_id = true;

        $scope.nonparametric_pipeline = false;
        $scope.$watch("nonparametric_pipeline",function(v){
          if(v){// nonparametric
            $scope.hide_nonparametric_post_hoc_test_type = false;
            $scope.hide_post_hoc_test_type = true;
            $scope.hide_type = true;
          }else{// parametric
            $scope.hide_nonparametric_post_hoc_test_type = true;
            $scope.hide_post_hoc_test_type = false;
            $scope.hide_type = false;
          }
        })


        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                "expression_text":tree_structure[i].text
              })

            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.group_name_options = doc.sample_info_column_name
          $scope.group_name_r_options = doc.sample_info_column_name
          $scope.group_name2_options = doc.sample_info_column_name
          $scope.group_name2_r_options = doc.sample_info_column_name
          $scope.sample_ID_name_options = doc.sample_info_column_name
          $scope.expression_id = localStorage.getItem('activated_data_id')
          if(typeof doc.study_design == 'string'){
            $scope.group_name = doc.study_design
            $scope.group_name_r = doc.study_design
            // when there is only one study design (string), we cannot guess a group_name for user.
            //$scope.group_name = doc.study_design
            //$scope.group_name_r = doc.study_design

          }else{
            if(doc.study_design_type1 == "independent"){
              $scope.group_name = doc.study_design[0]
            }else if(doc.study_design_type2 == "independent"){
              $scope.group_name = doc.study_design[1]
            }else{
              $scope.group_name = doc.study_design[0]
            }
            if(doc.study_design_type1 == "repeated"){
              $scope.group_name_r = doc.study_design[0]
            }else if(doc.study_design_type2 == "repeated"){
              $scope.group_name_r = doc.study_design[1]
            }else{
              $scope.group_name_r = doc.study_design[0]
            }

            // for group_name2, select the one that is not selected by group_name
            if($scope.group_name == doc.study_design[0]){
              $scope.group_name2 = doc.study_design[1]
            }else{
              $scope.group_name2 = doc.study_design[0]
            }
            if($scope.group_name_r == doc.study_design[0]){
              $scope.group_name2_r = doc.study_design[1]
            }else{
              $scope.group_name2_r = doc.study_design[0]
            }
          }
          $scope.sample_ID_name = doc.sample_id
          $scope.levels_options = doc.sample_info[$scope.group_name]
          $scope.levels2_options = doc.sample_info[$scope.group_name2]

          if($scope.$state.current.data.module_name.indexOf("t test")==-1){
            $scope.levels = doc.sample_info[$scope.group_name]
          }else{
            $scope.levels = doc.sample_info[$scope.group_name].slice(0, 2);
          }
          if(true){//$scope.$state.current.data.module_name.indexOf("t test")==-1
            $scope.levels2 = doc.sample_info[$scope.group_name2]
          }else{
            $scope.levels2 = doc.sample_info[$scope.group_name2].slice(0, 2);
          }


          $scope.change_group_name = function(){// when group_name changes, the levels changes.
            $scope.levels_options = doc.sample_info[$scope.group_name]
              if($scope.$state.current.data.module_name.indexOf("t test")==-1){
                $scope.levels = doc.sample_info[$scope.group_name]
              }else{
                $scope.levels = doc.sample_info[$scope.group_name].slice(0, 2);
              }
          }
          $scope.change_group_name2 = function(){// when group_name2 changes, the levels2 changes.
            $scope.levels2_options = doc.sample_info[$scope.group_name2]
              if(true){//$scope.$state.current.data.module_name.indexOf("t test")==-1
                $scope.levels2 = doc.sample_info[$scope.group_name2]
              }else{
                $scope.levels2 = doc.sample_info[$scope.group_name2].slice(0, 2);
              }
          }

          $scope.levels_r_options = doc.sample_info[$scope.group_name_r]
          if($scope.$state.current.data.module_name.indexOf("t test")==-1){
            $scope.levels_r = doc.sample_info[$scope.group_name_r]
          }else{
            $scope.levels_r = doc.sample_info[$scope.group_name_r].slice(0, 2);
          }
          $scope.levels2_r_options = doc.sample_info[$scope.group_name2_r]
          if(true){//$scope.$state.current.data.module_name.indexOf("t test")==-1
            $scope.levels2_r = doc.sample_info[$scope.group_name2_r]
          }else{
            $scope.levels2_r = doc.sample_info[$scope.group_name2_r].slice(0, 2);
          }

          $scope.change_group_name_r = function(){// when group_name_r changes, the levels_r changes.
            $scope.levels_r_options = doc.sample_info[$scope.group_name_r]
            if($scope.$state.current.data.module_name.indexOf("t test")==-1){
                $scope.levels_r = doc.sample_info[$scope.group_name_r]
              }else{
                $scope.levels_r = doc.sample_info[$scope.group_name_r].slice(0, 2);
              }
          }
          $scope.change_group_name2_r = function(){// when group_name_r changes, the levels_r changes.
            $scope.levels2_r_options = doc.sample_info[$scope.group_name2_r]
            if(true){//$scope.$state.current.data.module_name.indexOf("t test")==-1
                $scope.levels2_r = doc.sample_info[$scope.group_name2_r]
              }else{
                $scope.levels2_r = doc.sample_info[$scope.group_name2_r].slice(0, 2);
              }
          }
          $scope.type = "Welch"
          $scope.direction = "two.sided"
          $scope.get_direction_text = function() {
            if ($scope.direction == "two.sided") {
              return "Two sided"
            } else if($scope.direction == "less"){
              return "One sided: less"
            } else {
              return "One sided: greater"
            }
          };
          $scope.change_expression_id = function(){
            localStorage.setItem('activated_data_id', $scope.expression_id)
          }
          $scope.see_data_node = function(index){ // !!!
            localStorage.setItem('activated_data_id', expression_id_options[index].expression_id)
               $mdDialog.show({
                  templateUrl: '/ocpu/library/Abib.alpha/www/views/landing_page.html',
                  parent: angular.element(document.body),
                  clickOutsideToClose:true,
                  fullscreen: true
                })
          }


        })



        })



        $scope.submit = function(FUNCTION){
          var d = new Date();
          var time_string = d.getTime().toString()
          // change PARAMETER according to FUNCTION
          //var PARAMETER;
          switch (FUNCTION) {
              case "t_test":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name,
                    levels:$scope.levels,
                    direction:$scope.direction,
                    type:$scope.type,
                  }
                  break;
              case "paired_t_test":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name_r,
                    levels:$scope.levels_r,
                    direction:$scope.direction,
                    sample_ID_name:$scope.sample_ID_name
                  }
                  break;
               case "nonparametric_t_test":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name,
                    levels:$scope.levels,
                    direction:$scope.direction
                  }
                  break;
              case "nonparametric_paired_t_test":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name_r,
                    levels:$scope.levels_r,
                    direction:$scope.direction,
                    sample_ID_name:$scope.sample_ID_name
                  }
                  break;
              case "anova":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name,
                    levels:$scope.levels,
                    type:$scope.type,
                    post_hoc_test_type:$scope.post_hoc_test_type
                  }
                  break;
              case "nonparametric_anova":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name,
                    levels:$scope.levels,
                    post_hoc_test_type:$scope.nonparametric_post_hoc_test_type
                  }
                  break;
              case "repeated_anova":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name_r,
                    levels:$scope.levels_r,
                    post_hoc_test_type:$scope.post_hoc_test_type_r,
                    sample_ID_name:$scope.sample_ID_name,
                    sphericity_correction:$scope.sphericity_correction
                  }
                  break;
              case "nonparametric_repeated_anova":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name:$scope.group_name_r,
                    levels:$scope.levels_r,
                    post_hoc_test_type:$scope.nonparametric_post_hoc_test_type_r,
                    sample_ID_name:$scope.sample_ID_name
                  }
                  break;
              case "two_way_anova":
                if(!$scope.nonparametric_pipeline){
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name1:$scope.group_name,
                    levels1:$scope.levels,
                    group_name2:$scope.group_name2,
                    levels2:$scope.levels2,
                    type:$scope.type,
                    post_hoc_test_type:$scope.post_hoc_test_type
                  }
                }else{
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name1:$scope.group_name,
                    levels1:$scope.levels,
                    group_name2:$scope.group_name2,
                    levels2:$scope.levels2,
                    post_hoc_test_type:$scope.nonparametric_post_hoc_test_type
                  }
                }
                  break;
              case "two_way_mixed_anova":
                if(!$scope.nonparametric_pipeline){
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name2:$scope.group_name,
                    levels2:$scope.levels,
                    group_name1:$scope.group_name_r,
                    levels1:$scope.levels_r,
                    type:$scope.type,
                    post_hoc_test_type2:$scope.post_hoc_test_type,
                    post_hoc_test_type1:$scope.post_hoc_test_type_r,
                    sample_ID_name:$scope.sample_ID_name,
                    sphericity_correction:$scope.sphericity_correction
                  }
                }else{
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name2:$scope.group_name,
                    levels2:$scope.levels,
                    group_name1:$scope.group_name_r,
                    levels1:$scope.levels_r,
                    post_hoc_test_type2:$scope.nonparametric_post_hoc_test_type,
                    post_hoc_test_type1:$scope.nonparametric_post_hoc_test_type_r,
                    sample_ID_name:$scope.sample_ID_name,
                  }
                }
                  break;
              case 'others':
                  PARAMETER = {}
          }

          $scope.calculating = true;

          $scope.analysis_finished = false
          $scope.table_ready = false;
          var db_task = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task');
          // download csv for latter use (boxplot.)
          //var e; // e is the selected active data.
          Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+localStorage.getItem("activated_data_id").replace("_csv",".csv"), {
            header: true,
          	download: true,
          	complete: function(results) {
          		 e = results
          	}
          });
          //var p;  // phenotype data
Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {p = results;
if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
}});

          //var f;  // feature data
          /*Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+localStorage.getItem("activated_data_id").replace("_csv",".csv").replace("expression_data","metabolite_info"), {
            header: true,
          	download: true,
          	complete: function(results) {
          		 f = results
          	}
          });*/

          if(FUNCTION == 'two_way_anova' && $scope.nonparametric_pipeline){
            FUNCTION = 'nonparametric_two_way_anova'
          }
          if(FUNCTION == 'two_way_mixed_anova' && $scope.nonparametric_pipeline){
            FUNCTION = 'nonparametric_two_way_mixed_anova'
          }

            var newtask_id = localStorage.getItem("username") + "_68410298_" + time_string
            var new_task = {
              "_id":newtask_id,
              FUNCTION : FUNCTION,
              PARAMETER: PARAMETER,
              STATUS:"pending",PROJECT_ID:localStorage.getItem("project_id_global")
            }
            db_task.put(new_task).then(function(){
              console.log("Task added: "+newtask_id)
              var req = ocpu.call("CALCULATE_wrapper",{
                task_id:newtask_id
              },function(session){
                $scope.show_save_result = true
                sss = session
                session.getObject(function(obj){
                  ooo = obj
                  var csv = Papa.unparse(obj.out.table_data);
                  data_for_unparse = obj.out.table_data.slice(0)
                  $scope.save_result = function(){
                    $scope.saving = true
                    var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                    db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                      dd = doc

                      filename = get_filename_service.get_filename(doc,$scope.$state.current.data.pageTitle,sibling_id=PARAMETER.expression_id)

                      var parent_id = get_parent_service.get_parent(doc, PARAMETER.expression_id)

                      doc.tree_structure.push({
                        id:filename+"_68410298_"+time_string,
                        parent:parent_id,
                        text:filename,
                        icon:"fa fa-folder",
                        source:{
                          FUNCTION:FUNCTION,
                          PARAMETER:PARAMETER
                        },
                        source_node_id:PARAMETER.expression_id,
                        report:obj.out.report_text[0]
                      })
                      doc.tree_structure.push({
                        id:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+"_csv",
                        parent:filename+"_68410298_"+time_string,
                        text:$scope.$state.current.data.pageTitle+".csv",
                        icon:"fa fa-file-excel-o",
                        source:{
                          FUNCTION:FUNCTION,
                          PARAMETER:PARAMETER
                        },
                        attname:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv",
                        source_node_id:filename+"_68410298_"+time_string,
                        type:"compound_related_result"
                      })

                      doc['_attachments'][$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv"] = {
                        content_type:"application/vnd.ms-excel",
                        "data": btoa(csv)
                      }

                      db.put(doc).then(function(){
                          $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                         $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                         $scope.$apply(function(){
                           $scope.saving = false;
                           $scope.show_save_result = false;
                         })
                      })
                    })
                  }



                  $scope.$apply(function(){
                    // some utils.
                    $scope.analysis_finished = true
                    $scope.calculating = false;
                    // REPORT
                    $scope.report_text = obj.out.report_text[0]
                    // GRAPH
                    // pie chart
                    if(obj.out.graph_pie_data!==undefined) { // when user have the graph pie data, plot it directly. two group analysis.
                      $scope.graph_pie_data = $scope.plot_pie_graph(value = obj.out.graph_pie_data, table_data = obj.out.table_data, table_data_criterion = obj.out.table_data_criterion)
                    }else{
                      if($scope.pie_ready) {
                    			pie.destroy();
                    	}
                    }
                    // significancy_heatmap
                    if(obj.out.heatmap_data !== undefined) {
                      $scope.show_pie_chart = true;
                      $scope.plot_heatmap(xValues = PARAMETER.levels, yValues = PARAMETER.levels, zValues = obj.out.heatmap_data, table_data = obj.out.table_data, table_data_criterion = obj.out.table_data_criterion, graph_pie_data_for_click = obj.out.graph_pie_data_for_click)
                    }else{
                      if($("#significancy_heatmap").length>0){
                        Plotly.purge('significancy_heatmap');
                      }
                    }
                    // venn plot.
                    if(obj.out.venn_data1 !==undefined){
                      series1 = []
                      for(var i=0;i<Object.keys(obj.out.venn_data1).length;i++){
                        series1.push({
                          name:Object.keys(obj.out.venn_data1)[i],
                          data:obj.out.venn_data1[Object.keys(obj.out.venn_data1)[i]]
                        })
                      }
                      var series2 = []
                      for(var i=0;i<Object.keys(obj.out.venn_data2).length;i++){
                        series2.push({
                          name:Object.keys(obj.out.venn_data2)[i],
                          data:obj.out.venn_data2[Object.keys(obj.out.venn_data2)[i]]
                        })
                      }

                      $scope.plot_jvenn = function(s=series){
                        $scope.show_venn = true
                        $timeout(function(){
                          $('#venn').jvenn({
                              series: s,
                                displayStat: true,
                                fontFamily: "monospace",
                                shortNumber: false,
                                searchInput:  $("#search-field"),
                                searchStatus: $("#search-status"),
                                searchMinSize: 1,
                                fnClickCallback: function() {

                            			var selected_table_data = []
                            			for(var i=0;i<obj.out.table_data.length;i++){
                            			  if(this.list.indexOf(obj.out.table_data[i].label)!==-1){ // !!!.
                            			    selected_table_data.push(obj.out.table_data[i])
                            			  }
                            			}
                            			$scope.$apply(function(){
                            			  $scope.table_data = selected_table_data
                            			})
                            			sss = selected_table_data


                                }
                            });
                        },10)

                      }
                      $scope.plot_jvenn(s = series1)

                      $scope.switch_jvenn = function(cbState){
                        if(!cbState){
                          $scope.plot_jvenn(s = series1)
                        }else{
                          $scope.plot_jvenn(s = series2)
                        }
                      }

                    }else{
                      //!! destroy or hide the venn.
                      d3.select('#venn').selectAll('svg').remove();
                    }




                    // TABLE
                    $scope.table_selected = [];
                    var options = []
                    for(var i=0; i<obj.out.table_data_colnames.length; i++){
                      options.push({
                              name: obj.out.table_data_colnames[i],
                              prop: obj.out.table_data_colnames[i]
                            })
                    }

                    $scope.table_options.columns = options

                    ppp = $scope.table_options.columns

                    $scope.table_data = obj.out.table_data

                    ttt = obj.out.table_data

                    $scope.refresh_table = function(){
                      $scope.table_data = obj.out.table_data
                    }
                    $scope.table_ready = true;

                    $scope.on_table_row_click = function(row){
                      // when click table, display one-way boxplot OR two-way boxplot
                      rrr = row
                      par = PARAMETER
                      if($scope.$state.current.data.module_name=="t test"||$scope.$state.current.data.module_name=="nonparametric t test"||$scope.$state.current.data.module_name=="paired t test"||$scope.$state.current.data.module_name=="nonparametric paired t test"||$scope.$state.current.data.module_name=="ANOVA"||$scope.$state.current.data.module_name=="nonparametric ANOVA"||$scope.$state.current.data.module_name=="repeated ANOVA"||$scope.$state.current.data.module_name=="nonparametric repeated ANOVA"){
                            var group_name = PARAMETER.group_name
                            var group=[];
                            for(var i=0;i<p.data.length;i++){
                              if(PARAMETER.levels.indexOf(p.data[i][group_name])!==-1){
                                group.push(p.data[i][group_name])
                              }
                            }

                            for(var i=0;i<e.data.length;i++){
                              if(e.data[i]['label'] == row.label){
                                var compound_index = i;break;
                              }
                            }

                            var dta = e.data[compound_index]

                            var data=[]
                            for(var i=0; i<PARAMETER.levels.length;i++){
                              data.push({
                                y:[],
                                x:[],
                                name : PARAMETER.levels[i],
                                type:"box",
                                boxpoints: 'all'
                              })
                            }
                            for(var i=0;i<group.length;i++){
                              data[PARAMETER.levels.indexOf(group[i])].y.push(
                                dta[Object.keys(dta)[i+1]]
                              )
                              data[PARAMETER.levels.indexOf(group[i])].x.push(
                                group[i]
                              )
                            }

                            var layout = {
                               title: row.label,
                              yaxis: {
                                title: 'data value',
                                zeroline: false
                              },
                              boxmode: 'group'
                            };
                            Plotly.newPlot('one_way_boxplot', data, layout);

                      }else{

                        var group_name1 = PARAMETER.group_name1
                        var group1=[];
                        var group_name2 = PARAMETER.group_name2
                        var group2=[];
                        for(var i=0;i<p.data.length-1;i++){
                          if(PARAMETER.levels1.indexOf(p.data[i][group_name1])!==-1 && PARAMETER.levels2.indexOf(p.data[i][group_name2])!==-1){
                            group1.push(p.data[i][group_name1])
                            group2.push(p.data[i][group_name2])
                          }
                        }



                        var col_options = ["rgb(0,102,0)","rgb(90,155,212)","rgb(241,90,96)","rgb(250,220,91)","rgb(255,117,0)","rgb(192,152,83)"] // when more data is needed!!!
                        var data = []

                        for(var i=0; i<PARAMETER.levels2.length;i++){
                          data.push({
                            y:[],
                            x:[],
                            name : PARAMETER.levels2[i],
                            type:"box",
                            marker:{color:col_options[i]}
                          })
                        }
                        for(var i=0;i<e.data.length;i++){
                              if(e.data[i]['label'] == row.label){
                                var compound_index = i;break;
                              }
                            }

                        var dta = e.data[compound_index]
                        for( i=0;i<group2.length;i++){
                          data[PARAMETER.levels2.indexOf(group2[i])].y.push(
                            dta[Object.keys(dta)[i+1]]
                          )
                          data[PARAMETER.levels2.indexOf(group2[i])].x.push(
                            group1[i]
                          )
                        }




                        var group_name1_rev = PARAMETER.group_name2
                        var group1_rev=[];
                        var group_name2_rev = PARAMETER.group_name1
                        var group2_rev=[];
                        for(var i=0;i<p.data.length-1;i++){
                          if(PARAMETER.levels2.indexOf(p.data[i][group_name1_rev])!==-1 && PARAMETER.levels1.indexOf(p.data[i][group_name2_rev])!==-1){
                            group1_rev.push(p.data[i][group_name1_rev])
                            group2_rev.push(p.data[i][group_name2_rev])
                          }
                        }

                        var col_options = ["rgb(0,102,0)","rgb(90,155,212)","rgb(241,90,96)","rgb(250,220,91)","rgb(255,117,0)","rgb(192,152,83)"] // when more data is needed!!!
                        var data_rev = []

                        for(var i=0; i<PARAMETER.levels1.length;i++){
                          data_rev.push({
                            y:[],
                            x:[],
                            name : PARAMETER.levels1[i],
                            type:"box",
                            marker:{color:col_options[i]}
                          })
                        }
                        for(var i=0;i<e.data.length;i++){
                              if(e.data[i]['label'] == row.label){
                                var compound_index = i;break;
                              }
                            }

                        var dta = e.data[compound_index]
                        for( i=0;i<group2.length;i++){
                          data_rev[PARAMETER.levels1.indexOf(group2_rev[i])].y.push(
                            dta[Object.keys(dta)[i+1]]
                          )
                          data_rev[PARAMETER.levels1.indexOf(group2_rev[i])].x.push(
                            group1_rev[i]
                          )
                        }



                        $scope.generate_two_way_boxplot(d=data, label = row.label)
                        $scope.switch_two_way_box_plot_order = function(cbState){
                          if(!cbState){
                            $scope.generate_two_way_boxplot(d=data, label = row.label)
                          }else{
                            $scope.generate_two_way_boxplot(d=data_rev, label = row.label)
                          }
                        }
                      }

                    }
                  })
                }).fail(function(error){

                })
              }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
            })
          }


        $scope.report_message = "No report yet."
        $scope.data_message = "No data ouput yet."
        $scope.graph_message = "No graph yet."
        $scope.$on('data_message', function (event, arg) {
          $scope.data_message = arg;
        })
    })
    .controller("t_testCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("paired_t_testCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("nonparametric_t_testCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("nonparametric_paired_t_testCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("nonparametric_anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("repeated_anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("nonparametric_repeated_anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("two_way_anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("two_way_mixed_anovaCtrl", function($scope, $rootScope){
      $scope.refresh_all_options();
    })
    .controller("dimension_reductionCtrl", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdColorPalette, $mdToast, get_filename_service, get_parent_service){
      $scope.show_save_result = false;
        //$scope.colors = Object.keys($mdColorPalette);
          $scope.scale_options = [{
            value:"standard",
            text:"Auto Scaling (a.k.a unit variance scaling)"
          },{
            value:"pareto",
            text:"Pareto Scaling"
          },{
            value:"center",
            text:"Mean Centering"
          },{
            value:"none",
            text:"No Scaling"
          }]
          $scope.scaleC = "standard"

          $scope.algoC_options = [{
            value:"svd",
            text:"Singular-value decomposition"
          },{
            value:"nipals",
            text:"Nonlinear Iterative vartial Least Squares"
          }]

          $scope.permI = 100
          $scope.see_data_node = function(index){ // !!!
            localStorage.setItem('activated_data_id', expression_id_options[index].expression_id)
               $mdDialog.show({
                  templateUrl: '/ocpu/library/Abib.alpha/www/views/landing_page.html',
                  parent: angular.element(document.body),
                  clickOutsideToClose:true,
                  fullscreen: true
                })
          }
          $scope.analysis_finished = false
          $scope.calculating = false
        $scope.colors = ["#FF7F00","#1F78B4","#A6CEE3","#B2DF8A","#33A02C","#FB9A99","#E31A1C","#FDBF6F","#CAB2D6","#6A3D9A"]

        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                //"expression_parent_name":tree_structure[i].parent.split("_68410298_")[0],
                "expression_text":tree_structure[i].text
              })

            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.responses = doc.sample_info_column_name
          if(typeof doc.study_design == 'string'){
            $scope.response = doc.study_design

          }else{
            $scope.response = doc.study_design[0]
          }
          $scope.expression_id = localStorage.getItem('activated_data_id')
          $scope.change_expression_id = function(){
            localStorage.setItem('activated_data_id', $scope.expression_id)
          }

          $scope.$watch("$state.current.data.module_name",function(v){
            console.log(v)
            if(v=="PCA"){
              $scope.algoC = "svd"
              if(typeof doc.study_design == 'string'){
                $scope.plot_parameter.color_group_name = doc.study_design
              }else{
                $scope.plot_parameter.color_group_name = doc.study_design[0]
              }
            }else{
              $scope.algoC = "nipals"
              $scope.plot_parameter.color_group_name = $scope.response
              console.log($scope.plot_parameter.color_group_name)
            }
          })
          // plot parameter
          $scope.plot_parameter = {
            use_color:true,
            color_group_name_options:doc.sample_info_column_name,
            use_label:false,
            label_group_name_options:doc.sample_info_column_name,
            label_group_name:"label",
            width:700,
            height:450,
            size:12,
            xaxis_title: "pc1",
            yaxis_title: "pc2"
          }



          $scope.$watch("plot_parameter.color_group_name",function(value){
            $scope.plot_parameter.color_levels_options = doc.sample_info[value]
            $scope.plot_parameter.selected_colors = $scope.colors.slice(0,$scope.plot_parameter.color_levels_options.length)
          },true)
          $scope.change_color = function(color,index){
            $scope.plot_parameter.selected_colors[index] = $scope.colors[$scope.colors.indexOf($scope.plot_parameter.selected_colors[index])+1]
          }





        })
        })

        $scope.submit = function(FUNCTION){


          var d = new Date();
          var time_string = d.getTime().toString()
          switch (FUNCTION) {
              case "pca":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],//!!!
                    scaleC:$scope.scaleC,
                    algoC:$scope.algoC
                  }
                  break;
              case 'pls':
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    scaleC:$scope.scaleC,
                    algoC:$scope.algoC,
                    response:$scope.response,
                    permI:$scope.permI
                  }
                  break;
              case 'others':
                  PARAMETER = {}
          }

          $scope.calculating = true;
          $scope.analysis_finished = false
          $scope.table_ready = false;
            var db_task = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task');
            // download csv for latter use (boxplot.)
            //var e; // expression data
            Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+localStorage.getItem("activated_data_id").replace("_csv",".csv"), {
              header: true,
            	download: true,
            	complete: function(results) {
            		 e = results
            		 e.data.pop()
            	}
            });
            //var p;  // phenotype data
Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {p = results;
if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
}});


            var newtask_id = localStorage.getItem("username") + "_68410298_" + time_string
            var new_task = {
              "_id":newtask_id,
              FUNCTION : FUNCTION,
              PARAMETER: PARAMETER,
              STATUS:"pending",PROJECT_ID:localStorage.getItem("project_id_global")
            }
            db_task.put(new_task).then(function(){
              console.log("Task added: "+newtask_id)
              var req = ocpu.call("CALCULATE_wrapper",{
                task_id:newtask_id
              },function(session){
                $scope.show_save_result = true
                $scope.calculating = false
                sss = session
                session.getObject(function(obj){
                  ooo = obj

                  var scores_csv = Papa.unparse(obj.out.scores);
                  var loadings_csv = Papa.unparse(obj.out.loadings);
                  var var_exp_csv = Papa.unparse(obj.out.var_exp);
                  if($scope.$state.current.data.module_name==='PLS'){
                    var model_summary_csv = Papa.unparse(obj.out.model_summary);
                    var VIP_score_csv = Papa.unparse(obj.out.VIP_score);
                  }

                  $scope.$apply(function(){
                    // some utils.
                    $scope.analysis_finished = true
                    var score_plot = function(x, y, text, use_color, color, color_options, use_label, width, height, size, xaxis_title, yaxis_title, ellipse= null){
                      var unique_color = color.filter(function(value, index, self){return self.indexOf(value)===index;})
                      var data = []
                      if(use_color){
                        for(var i=0; i<unique_color.length;i++){
                          var index_by_color = color.reduce(function(a, e, j) {
                                                    if (e === unique_color[i])
                                                        a.push(j);
                                                    return a;
                                                }, [])
                          var trace = {
                            x:x.filter((elt, i) => index_by_color.indexOf(i) > -1),
                            y:y.filter((elt, i) => index_by_color.indexOf(i) > -1),
                            mode:"markers",
                            type:'scatter',
                            name:unique_color[i],
                            text:text.filter((elt, i) => index_by_color.indexOf(i) > -1),
                            marker:{color:color_options[i], size:size,line:{color:'rgba(217, 217, 217)',width:2},opacity: 0.75}
                          }
                          data.push(trace)
                          if(ellipse !== null){
                            data.push({
                              x:ellipse[i].map(function(val){return val[0]}),
                              y:ellipse[i].map(function(val){return val[1]}),
                              mode:"lines",
                              type:'scatter',
                              name:unique_color[i],
                              marker:{color:color_options[i]},
                              showlegend:false,hoverinfo: 'none'
                            })
                          }
                        }
                      }else{
                          data.push({
                            x:x,
                            y:y,
                            mode:"markers",
                            type:'scatter',
                            name:unique_color[i],
                            text:text,
                            marker:{color:'black',size:size,line:{color:'rgba(217, 217, 217)',width:2},opacity: 0.75}
                          })
                          if(ellipse !== null){
                          data.push({
                              x:ellipse[0].map(function(val){return val[0]}),
                              y:ellipse[0].map(function(val){return val[1]}),
                              mode:"lines",
                              type:'scatter',
                              marker:{color:'black'},
                              showlegend:false,hoverinfo: 'none'
                            })
                          }
                      }
                      if(use_label){
                        for(var i=0; i<data.length;i++){
                          data[i].textposition = "top center"
                          data[i].mode = "markers+text"
                        }
                      }
                      var layout = {
                        width: width,
                        height: height,
                        xaxis:{title:xaxis_title},
                        yaxis:{title:yaxis_title},
                        title:'<b>Score Plot</b>',
                        hovermode:"closest"
                      };
                      Plotly.purge('score_plot');
                      Plotly.newPlot('score_plot', data, layout).then(
                        function(gd)
                         {
                          Plotly.toImage(gd,{height:layout.height,width:layout.width})
                             .then(
                                function(url)
                             {
                                 score_plot_url = url
                                 return Plotly.toImage(gd,{format:'png',height:layout.height,width:layout.width});
                             }
                             )
                        });

                      var score_plotDiv = document.getElementById('score_plot');
                      score_plotDiv.on("plotly_selected", function(eventData){
                        eee = eventData
                        if(eventData === undefined){// this means that the user has canceled the selection.
                            $scope.$apply(function(){$scope.selected_sample_data_ready = false;})
                        }else{
                            xx = x; yy = y;
                            var selected = [];
                            eventData.points.forEach(function(pt) {
                              if(x.indexOf(pt.x) == y.indexOf(pt.y)){
                                selected.push(x.indexOf(pt.x))
                              }
                            });
                            var selected_label = []; // sample label selected
                            for(var i=0;i<selected.length;i++){
                              selected_label.push(
                                p.data[selected[i]]['label']
                              )
                            }
                            var binded_data = p.data
                            var selected_sample_columns=[]
                            Object.keys(binded_data[0]).forEach(function(pt){
                              selected_sample_columns.push({name: pt,prop: pt})
                            })
                            var selected_sample_data = []
                            for(var i=0; i<binded_data.length;i++){
                              for(var j=0;j<selected_label.length;j++){
                                if(binded_data[i]['label'].indexOf(selected_label[j])!==-1){
                                  selected_sample_data.push(binded_data[i])
                                }
                              }
                            }

                            $scope.$apply(function(){
                              $scope.selected_sample_data_ready = true;
                              $scope.selected_binded_table_options = {
                                footerHeight: false,
                                scrollbarV: true,
                                headerHeight: 50,
                                selectable: false,
                                multiSelect: false,
                                sortable:false,
                                columnMode:"force",
                                columns: selected_sample_columns
                              };// for initializing the table.
                              $scope.selected_sample_data = selected_sample_data;
                            })
                        }



                      })
                    }
                    $scope.plot_parameter.pcx_options = []
                    $scope.plot_parameter.pcy_options = []
                    for(var i=0;i<obj.out.var_exp.length;i++){
                      $scope.plot_parameter.pcx_options.push({
                        value:"p"+Number(i+1),
                        text:obj.out.var_exp[i].PC +" ("+obj.out.var_exp[i].percentage.toFixed(2)+"%)"
                      })
                      $scope.plot_parameter.pcy_options.push({
                        value:"p"+Number(i+1),
                        text:obj.out.var_exp[i].PC +" ("+obj.out.var_exp[i].percentage.toFixed(2)+"%)"
                      })
                    }
                    $scope.plot_parameter.pcx = 'p1'
                    $scope.$watch("plot_parameter.pcx",function(value){
                      for(var i=0; i<$scope.plot_parameter.pcx_options.length;i++){
                        if($scope.plot_parameter.pcx_options[i].value==value){
                          $scope.plot_parameter.pcx_title = $scope.plot_parameter.pcx_options[i].text
                        }
                      }
                    },true)
                    $scope.plot_parameter.pcy = 'p2'
                    $scope.$watch("plot_parameter.pcy",function(value){
                      for(var i=0; i<$scope.plot_parameter.pcy_options.length;i++){
                        if($scope.plot_parameter.pcy_options[i].value==value){
                          $scope.plot_parameter.pcy_title = $scope.plot_parameter.pcy_options[i].text
                        }
                      }
                    },true)
                    // ellipse
                    /*$scope.$watch('use_ellipse',function(newValue, oldValue){
                      if(newValue !== oldValue){
                        console.log("!")
                        if(newValue){
                        var color=[]
                          for(var i=0;i<p.data.length;i++){
                            color.push(p.data[i][$scope.plot_parameter.color_group_name])
                          }
                          $scope.updating_ellipse = true
                          // need to work on this.
                          // R FUNCTION add_ellipse_to_score_plot
                          var req = ocpu.call("add_ellipse_to_score_plot",{
                            scores:obj.out.scores,
                            use_color:$scope.plot_parameter.use_color,
                            color:color,
                            selected_colors:$scope.plot_parameter.selected_colors,
                            pcx:ppp.pcx,
                            pcy:ppp.pcy
                          },function(session){
                            sss = session
                            session.getObject(function(object){
                              oo = object
                              $scope.$apply(function(){
                                var ellipse = object.ellipse
                                var x = [];
                                var y = [];
                                for(var i=0;i<obj.out.scores.length;i++){
                                  x.push(obj.out.scores[i][$scope.plot_parameter.pcx])
                                  y.push(obj.out.scores[i][$scope.plot_parameter.pcy])
                                }
                                color=[]
                                text=[]
                                for(var i=0;i<p.data.length;i++){
                                  color.push(p.data[i][$scope.plot_parameter.color_group_name])
                                  text.push(p.data[i][$scope.plot_parameter.label_group_name])
                                }
                                score_plot(x = x, y = y, text = text,use_color=$scope.plot_parameter.use_color, color=color,color_options = $scope.plot_parameter.selected_colors, use_label=$scope.plot_parameter.use_label, width=$scope.plot_parameter.width, height=$scope.plot_parameter.height,size=$scope.plot_parameter.size, xaxis_title=$scope.plot_parameter.pcx_title, yaxis_title=$scope.plot_parameter.pcy_title, ellipse = ellipse)

                                $scope.updating_ellipse = false
                              })
                            })

                          })
                        }else{
                          var x = [];
                          var y = [];
                          for(var i=0;i<obj.out.scores.length;i++){
                            x.push(obj.out.scores[i][$scope.plot_parameter.pcx])
                            y.push(obj.out.scores[i][$scope.plot_parameter.pcy])
                          }
                          color=[]
                          text=[]
                          for(var i=0;i<p.data.length;i++){
                            color.push(p.data[i][$scope.plot_parameter.color_group_name])
                            text.push(p.data[i][$scope.plot_parameter.label_group_name])
                          }
                          score_plot(x = x, y = y, text = text,use_color=$scope.plot_parameter.use_color, color=color,color_options = $scope.plot_parameter.selected_colors, use_label=$scope.plot_parameter.use_label, width=$scope.plot_parameter.width, height=$scope.plot_parameter.height,size=$scope.plot_parameter.size, xaxis_title=$scope.plot_parameter.pcx_title, yaxis_title=$scope.plot_parameter.pcy_title)
                          $scope.updating_ellipse = false
                        }
                      }


                    },true)*/

                    // when parameter changes, replot the score plot.
                    $scope.$watch("plot_parameter",function(value){
                      console.log("parameter changed!")
                      $scope.use_ellipse = false
                      ppp = $scope.plot_parameter
                      x = [];
                      y = [];
                      for(var i=0;i<obj.out.scores.length;i++){
                        x.push(obj.out.scores[i][$scope.plot_parameter.pcx])
                        y.push(obj.out.scores[i][$scope.plot_parameter.pcy])
                      }
                      color=[]
                      text=[]
                      for(var i=0;i<p.data.length;i++){
                        color.push(p.data[i][value.color_group_name])
                        text.push(p.data[i][value.label_group_name])
                      };Plotly.purge('score_plot');
                      score_plot(x = x, y = y, text = text,use_color=value.use_color, color=color,color_options = value.selected_colors, use_label=value.use_label, width=value.width, height=value.height,size=value.size, xaxis_title=value.pcx_title, yaxis_title=value.pcy_title)
                    },true)



                    // loadings plot
                    loadings_plot_parameter = {
                      pcx:"p1",
                      pcy:"p2",
                      showlabel:false,
                      width:700,
                      height:450
                    }
                    $scope.loadings_plot_parameter = loadings_plot_parameter;
                    $scope.$watch("loadings_plot_parameter",function(value){
                      var loading_data = [{
                        x:obj.out.loadings.map(x => x[$scope.loadings_plot_parameter.pcx]),
                        y:obj.out.loadings.map(y => y[$scope.loadings_plot_parameter.pcy]),
                        mode: $scope.loadings_plot_parameter.showlabel? "markers+text":"markers",
                        text:obj.out.loadings.map(l => l.label)
                      }]
                      var loading_layout={
                        title:"<b>Loadings Plot</b>",
                        hovermode:"closest",
                        width:$scope.loadings_plot_parameter.width,
                        height:$scope.loadings_plot_parameter.height
                      };Plotly.purge('loading_plot');
                      Plotly.newPlot('loading_plot', loading_data, loading_layout).then(
                        function(gd)
                         {
                          Plotly.toImage(gd,{height:loading_layout.height,width:loading_layout.width})
                             .then(
                                function(url)
                             {
                                 loading_plot_url = url
                                 return Plotly.toImage(gd,{format:'png',height:loading_layout.height,width:loading_layout.width});
                             }
                             )
                        })
                    },true)


                    // VIP score plot
                    vip_score_plot_parameters = {
                      num_to_show:20,
                      width:800,
                      height:600
                    }
                    $scope.vip_score_plot_parameters = vip_score_plot_parameters;
                    $scope.$watch("vip_score_plot_parameters",function(value){
                      label = []; var x = [];
                      for(var i=obj.out.VIP_score_sort.length-1;i>obj.out.VIP_score_sort.length - vip_score_plot_parameters.num_to_show - 1;i--){
                        label.push(obj.out.VIP_score_sort[i].label)
                        x.push(obj.out.VIP_score_sort[i].V2)
                      }
                      label.reverse();
                      x.reverse();
                      label = label.map(l => "_"+l)

                      var vip_data = [{
                        type:"scatter",
                        x:x,
                        y:label,mode:'markers',marker:{size:12}
                      }]
                      var vip_layout = {
                        title:"<b>VIP scores</b>",
                        width:$scope.vip_score_plot_parameters.width,
                        height:$scope.vip_score_plot_parameters.height,
                        margin:{l:160}
                      }
                      Plotly.purge('vip_plot');
                      Plotly.newPlot('vip_plot', vip_data, vip_layout).then(
                        function(gd)
                         {
                          Plotly.toImage(gd,{height:vip_layout.height,width:vip_layout.width})
                             .then(
                                function(url)
                             {
                                 vip_plot_url = url
                                 return Plotly.toImage(gd,{format:'png',height:vip_layout.height,width:vip_layout.width});
                             }
                             )
                        })
                    },true)


                    // permutation plot
                    permutation_plot_parameters = {
                      width:800,
                      height:600
                    }
                    $scope.permutation_plot_parameters = permutation_plot_parameters;
                    $scope.$watch("permutation_plot_parameters",function(value){



                      var permutation_data = [{
                        type:"histogram",
                        x:obj.out.permutation_summary.map(i => i[2])
                      }]
                      var permutation_layout = {
                        title:"<b>permutation test result <em>(p value:"+obj.out.permutation_sig[0].toFixed(4)+")</em></b>",
                        width:$scope.permutation_plot_parameters.width,
                        height:$scope.permutation_plot_parameters.height,
                        margin:{l:160},
                        shapes:[{
                          type:'line',
                          x0:obj.out.permutation_summary[0][2],
                          x1:obj.out.permutation_summary[0][2],
                          y0:0,
                          y1:$scope.permI/10,
                           line: {
                            color: 'red',
                            width: 2
                          }
                        }]
                      }
                      Plotly.purge('permutation_plot');
                      Plotly.newPlot('permutation_plot', permutation_data, permutation_layout).then(
                        function(gd)
                         {
                          Plotly.toImage(gd,{height:permutation_layout.height,width:permutation_layout.width})
                             .then(
                                function(url)
                             {
                                 permutation_plot_url = url
                                 return Plotly.toImage(gd,{format:'png',height:permutation_layout.height,width:permutation_layout.width});
                             }
                             )
                        })
                    },true)



                     $scope.save_result = function(){
                        $scope.saving = true
                        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                        db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                          dd = doc
                          filename = get_filename_service.get_filename(doc,$scope.$state.current.data.pageTitle,sibling_id=PARAMETER.expression_id)
                          var parent_id = get_parent_service.get_parent(doc, PARAMETER.expression_id)
                          doc.tree_structure.push({
                            id:filename+"_68410298_"+time_string,
                            parent:parent_id,
                            text:filename,
                            icon:"fa fa-folder",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:PARAMETER.expression_id,
                            report:obj.out.report_text[0]
                          })
                          doc.tree_structure.push({
                            id:"scores"+"_68410298_"+time_string+"_csv",
                            parent:filename+"_68410298_"+time_string,
                            text:"scores.csv",
                            icon:"fa fa-file-excel-o",
                            attname:"scores"+"_68410298_"+time_string+".csv",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:filename+"_68410298_"+time_string,
                            type:"sample_related_result"
                          })
                          doc.tree_structure.push({
                            id:"loadings"+time_string+"_csv",
                            parent:filename+"_68410298_"+time_string,
                            text:"loadings.csv",
                            icon:"fa fa-file-excel-o",
                            attname:"loadings"+"_68410298_"+time_string+".csv",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:filename+"_68410298_"+time_string,
                            type:"compound_related_result"
                          })
                          doc.tree_structure.push({
                            id:"var_exp"+"_68410298_"+time_string+"_csv",
                            parent:filename+"_68410298_"+time_string,
                            text:"var_exp.csv",
                            icon:"fa fa-file-excel-o",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:filename+"_68410298_"+time_string,
                            attname:"var_exp"+"_68410298_"+time_string+".csv"
                          })
                          doc.tree_structure.push({
                            id:"score_plot"+"_68410298_"+time_string+"_png",
                            parent:filename+"_68410298_"+time_string,
                            text:"score_plot.png",
                            icon:"fa fa-file-picture-o",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:filename+"_68410298_"+time_string,
                            attname:"score_plot"+"_68410298_"+time_string+".png"
                          })
                          doc.tree_structure.push({
                            id:"loading_plot"+"_68410298_"+time_string+"_png",
                            parent:filename+"_68410298_"+time_string,
                            text:"loading_plot.png",
                            icon:"fa fa-file-picture-o",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:filename+"_68410298_"+time_string,
                            attname:"loading_plot"+"_68410298_"+time_string+".png"
                          })

                          if($scope.$state.current.data.module_name==='PLS'){
                            doc.tree_structure.push({
                              id:"model_summary"+"_68410298_"+time_string+"_csv",
                              parent:filename+"_68410298_"+time_string,
                              text:"model_summary.csv",
                              icon:"fa fa-file-excel-o",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              source_node_id:filename+"_68410298_"+time_string,
                              attname:"model_summary"+"_68410298_"+time_string+".csv"
                            })
                            doc.tree_structure.push({
                              id:"VIP_score"+"_68410298_"+time_string+"_csv",
                              parent:filename+"_68410298_"+time_string,
                              text:"VIP_score.csv",
                              icon:"fa fa-file-excel-o",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              source_node_id:filename+"_68410298_"+time_string,
                              attname:"VIP_score"+"_68410298_"+time_string+".csv",
                              type:"compound_related_result"
                            })
                            doc.tree_structure.push({
                              id:"vip_score_plot"+"_68410298_"+time_string+"_png",
                              parent:filename+"_68410298_"+time_string,
                              text:"vip_score_plot.png",
                              icon:"fa fa-file-picture-o",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              source_node_id:filename+"_68410298_"+time_string,
                              attname:"vip_score_plot"+"_68410298_"+time_string+".png"
                            })
                            doc.tree_structure.push({
                              id:"permutation_plot"+"_68410298_"+time_string+"_png",
                              parent:filename+"_68410298_"+time_string,
                              text:"permutation_plot.png",
                              icon:"fa fa-file-picture-o",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              source_node_id:filename+"_68410298_"+time_string,
                              attname:"permutation_plot"+"_68410298_"+time_string+".png"
                            })
                          }

                          doc['_attachments']["scores"+"_68410298_"+time_string+".csv"] = {
                            content_type:"application/vnd.ms-excel",
                            "data": btoa(scores_csv)
                          }
                          doc['_attachments']["loadings"+"_68410298_"+time_string+".csv"] = {
                            content_type:"application/vnd.ms-excel",
                            "data": btoa(loadings_csv)
                          }
                          doc['_attachments']["var_exp"+"_68410298_"+time_string+".csv"] = {
                            content_type:"application/vnd.ms-excel",
                            "data": btoa(var_exp_csv)
                          }
                          doc['_attachments']["score_plot"+"_68410298_"+time_string+".png"] = {
                            content_type:"image/png",
                            "data": score_plot_url.split("base64,")[1]
                          }
                          doc['_attachments']["loading_plot"+"_68410298_"+time_string+".png"] = {
                            content_type:"image/png",
                            "data": loading_plot_url.split("base64,")[1]
                          }

                          if($scope.$state.current.data.module_name==='PLS'){
                            doc['_attachments']["model_summary"+"_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(model_summary_csv)
                            }
                            doc['_attachments']["VIP_score"+"_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(VIP_score_csv)
                            }
                            doc['_attachments']["vip_score_plot"+"_68410298_"+time_string+".png"] = {
                              content_type:"image/png",
                              "data": vip_plot_url.split("base64,")[1]
                            }
                            doc['_attachments']["permutation_plot"+"_68410298_"+time_string+".png"] = {
                              content_type:"image/png",
                              "data": permutation_plot_url.split("base64,")[1]
                            }
                          }




                          db.put(doc).then(function(){
                            $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                             $scope.$apply(function(){
                               $scope.saving = false;
                               $scope.show_save_result = false;
                               $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                             })
                          })

                        })
                      }

                  })
                })
              }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
            })
        }
    })
    .controller("pcaCtrl", function($scope, $rootScope){

        $scope.submit_button_html = "Submit"
        $scope.$on('submit_button_html', function() {
          $scope.submit_button_html = "Submit"
        });
        $scope.$on('calculating', function() {
          $scope.calculating = false;
        });
        $scope.calculating = false;

    })
    .controller("plsCtrl", function($scope, $rootScope){

        $scope.submit_button_html = "Submit"
        $scope.$on('submit_button_html', function() {
          $scope.submit_button_html = "Submit"
        });
        $scope.$on('calculating', function() {
          $scope.calculating = false;
        });
        $scope.calculating = false;

    })
    .controller("filemanipulationCtrl", function($scope, $rootScope){

    })
    .controller("subsettingCtrl", function($scope, $rootScope, $mdDialog, $mdToast, get_filename_service, get_parent_service){

        $scope.before_table_ready = false
        $scope.after_table_ready = false
        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var sample_related_result_options = []
          var compound_related_result_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                "expression_text":tree_structure[i].text
              })
            }else if(tree_structure[i].type == "sample_related_result"){
              sample_related_result_options.push({
                "sample_related_result_id":tree_structure[i].id,
                "sample_related_result_text":tree_structure[i].text
              })
            }else if(tree_structure[i].type == "compound_related_result"){
              compound_related_result_options.push({
                "compound_related_result_id":tree_structure[i].id,
                "compound_related_result_text":tree_structure[i].text
              })
            }
          }


        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.expression_id = localStorage.getItem('activated_data_id')
          $scope.sample_related_result_options = sample_related_result_options
          $scope.sample_related_result_id = localStorage.getItem('activated_data_id').replace("expression_data","sample_info")
          $scope.compound_related_result_options = compound_related_result_options
          $scope.compound_related_result_id = localStorage.getItem('activated_data_id').replace("expression_data","metabolite_info")
          $scope.before_table_options = {
            footerHeight: false,
            scrollbarV: true,
            headerHeight: 50,
            selectable: false,
            sortable:false,
            columnMode:"force"
          };
          $scope.after_table_options = {
            footerHeight: false,
            scrollbarV: true,
            headerHeight: 50,
            selectable: false,
            sortable:false,
            columnMode:"force"
          };

          $scope.$watch("expression_id",function(value){
             Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+value.replace("_csv",".csv"), {
               header: true,
            	 download: true,
            	 complete: function(results) {
            	   e = results
            	   e.data.pop()
                  var options = []
                  for(var i=0; i<Object.keys(e.data[0]).length; i++){
                    options.push({
                            name: Object.keys(e.data[0])[i],
                            prop: Object.keys(e.data[0])[i]
                          })
                  }

                  $scope.before_table_options.columns = options

                  $scope.before_table_data = e.data

                  $scope.before_table_ready = true

                  $scope.before_nrow = e.data.length
                  $scope.before_ncol = Object.keys(e.data[0]).length
            	 }
             })
          })

          $scope.$watch("sample_related_result_id",function(value){
            Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+value.replace("_csv",".csv"), {
              header: true,
            	download: true,
            	complete: function(results) {
            		  sample_criterion_data = results
            		  sample_criterion_data.data.splice(sample_criterion_data.data.length-1,1)
            		  t = sample_criterion_data.data.map(function(x){
            		    var value =  Object.values(x).map(function(y){
            		      return (isNaN(Number(y)))
            		    })
            		    return value
            		  })
            		  var column_options = {text:[],type:{},number_options:{},values:{}}
            		  for(var j=0; j<t[0].length;j++){
            		    column_options.text.push(Object.keys(sample_criterion_data.data[0])[j])
            		    column_options.values[Object.keys(sample_criterion_data.data[0])[j]] = sample_criterion_data.data.map(function(x){return x[Object.keys(sample_criterion_data.data[0])[j]]}).filter(function(value,index,self){return self.indexOf(value)===index})
            		    if(t.map(function(i){return i[j]}).reduce((a, b) => a + b, 0)==0){
            		      column_options.type[Object.keys(sample_criterion_data.data[0])[j]] = "number"
            		      column_options.number_options[Object.keys(sample_criterion_data.data[0])[j]] = {
            		        min:Math.min(...column_options.values[Object.keys(sample_criterion_data.data[0])[j]]),
            		        max:Math.max(...column_options.values[Object.keys(sample_criterion_data.data[0])[j]]),
            		        by:(Math.max(...column_options.values[Object.keys(sample_criterion_data.data[0])[j]])-Math.min(...column_options.values[Object.keys(sample_criterion_data.data[0])[j]]))/1000
            		      }
            		    }else{
            		      column_options.type[Object.keys(sample_criterion_data.data[0])[j]] = "character"
            		    }


            		  }

          		    $scope.sample_column_option_criterions = [
                    Object.assign({id:1},column_options)
                  ]


                  $scope.add_sample_criterion = function(){
                    $scope.sample_column_option_criterions.push(Object.assign({id:$scope.sample_column_option_criterions.length+1},column_options))
                  }
                  $scope.remove_sample_criterion = function(){
                    $scope.sample_column_option_criterions.pop()
                  }

            	}
            });
          },true)

          $scope.$watch("compound_related_result_id",function(value){
            Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+value.replace("_csv",".csv"), {
              header: true,
            	download: true,
            	complete: function(results) {
            		  compound_criterion_data = results
            		  compound_criterion_data.data.splice(compound_criterion_data.data.length-1,1)
            		  t = compound_criterion_data.data.map(function(x){
            		    var value =  Object.values(x).map(function(y){
            		      return (isNaN(Number(y)))
            		    })
            		    return value
            		  })
            		  var column_options = {text:[],type:{},number_options:{},values:{}}
            		  for(var j=0; j<t[0].length;j++){
            		    column_options.text.push(Object.keys(compound_criterion_data.data[0])[j])
            		    column_options.values[Object.keys(compound_criterion_data.data[0])[j]] = compound_criterion_data.data.map(function(x){return x[Object.keys(compound_criterion_data.data[0])[j]]}).filter(function(value,index,self){return self.indexOf(value)===index})
            		    if(t.map(function(i){return i[j]}).reduce((a, b) => a + b, 0)==0){
            		      column_options.type[Object.keys(compound_criterion_data.data[0])[j]] = "number"
            		      column_options.number_options[Object.keys(compound_criterion_data.data[0])[j]] = {
            		        min:Math.min(...column_options.values[Object.keys(compound_criterion_data.data[0])[j]]),
            		        max:Math.max(...column_options.values[Object.keys(compound_criterion_data.data[0])[j]]),
            		        by:(Math.max(...column_options.values[Object.keys(compound_criterion_data.data[0])[j]])-Math.min(...column_options.values[Object.keys(compound_criterion_data.data[0])[j]]))/1000
            		      }
            		    }else{
            		      column_options.type[Object.keys(compound_criterion_data.data[0])[j]] = "character"
            		    }


            		  }

          		    $scope.compound_column_option_criterions = [
                    Object.assign({id:1},column_options)
                  ]


                  $scope.add_compound_criterion = function(){
                    $scope.compound_column_option_criterions.push(Object.assign({id:$scope.compound_column_option_criterions.length+1},column_options))
                  }
                  $scope.remove_compound_criterion = function(){
                    $scope.compound_column_option_criterions.pop()
                  }

            	}
            });
          },true)


          $scope.submit = function(){
          var d = new Date();
          var time_string = d.getTime().toString()
            sss = $scope.sample_column_option_criterions
            ccc = $scope.compound_column_option_criterions


            // subset by samples first
            var sample_index = Array(sample_criterion_data.data.length).fill(true)
            for(var i=0; i<sss.length;i++){
              var column = sss[i].column
              // check if this column is character or number
              if(sss[i].type[column] == 'character'){
                sample_criterion_data.data.map(function(x, index){
                  if(sss[i].selected.indexOf(x[column])!==-1){
                    sample_index[index] = true && sample_index[index]
                  }else{
                    sample_index[index] = false && sample_index[index]
                  }
                })
              }else if(sss[i].type[column] == 'number'){
                sample_criterion_data.data.map(function(x, index){
                  if(x[column] < sss[i].max && x[column] > sss[i].min){
                    sample_index[index] = true && sample_index[index]
                  }else{
                    sample_index[index] = false && sample_index[index]
                  }
                })
              }
            }
            // subset by compounds first
            var compound_index = Array(e.data.length).fill(true)
            for(var i=0; i<ccc.length;i++){
              var column = ccc[i].column
              // check if this column is character or number
              if(ccc[i].type[column] == 'character'){
                compound_criterion_data.data.map(function(x, index){
                  if(ccc[i].selected.indexOf(ccc[i].selected)!==-1){
                    compound_index[index] = true && compound_index[index]
                  }else{
                    compound_index[index] = false && compound_index[index]
                  }
                })
              }else if(ccc[i].type[column] == 'number'){
                compound_criterion_data.data.map(function(x, index){
                  if(x[column] < ccc[i].max && x[column] > ccc[i].min){
                    compound_index[index] = true && compound_index[index]
                  }else{
                    compound_index[index] = false && compound_index[index]
                  }
                })
              }
            }

            // start subsetting on the e data.
            after = []
            for(var i=0;i<compound_index.length;i++){
              if(compound_index[i]){
                var new_row = {}
                new_row.label = e.data[i].label
                for(var j=0;j<sample_index.length;j++){
                  if(sample_index[j]){
                    new_row[Object.keys(e.data[i])[j+1]] = e.data[i][Object.keys(e.data[i])[j+1]]
                  }
                }
                after.push(new_row)
              }
            }
            // now update the after_table_data
            var options = []
            for(var i=0; i<Object.keys(after[0]).length; i++){
              options.push({
                      name: Object.keys(after[0])[i],
                      prop: Object.keys(after[0])[i]
                    })
            }

            $scope.after_table_options.columns = options
            $scope.after_table_data = after

            $scope.after_table_ready = true

            $scope.after_nrow = after.length
            $scope.after_ncol = Object.keys(after[0]).length

            var csv = Papa.unparse(after);
            $scope.show_save = true


            Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {
              p = results;
              if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
              var after_sample_labels = Object.keys(after[0])
              after_p = [];
              for(var j=0;j<p.data.length;j++){
                  if(after_sample_labels.indexOf(p.data[j].label)!==-1){
                    after_p.push(p.data[j])
                  }
                }
                p_csv = Papa.unparse(after_p);
            }});




            $scope.confirm_save = function(ev){
              $scope.saving = true
              var confirm = $mdDialog.prompt()
              .title('Give a name of the subset file.')
              .textContent('Please do not include any special characters.')
              .placeholder('input a name without special characters.')
              .ariaLabel('file name')
              .targetEvent(ev)
              .required(true)
              .ok('Create!')
              .cancel('Cancel it.');

              $mdDialog.show(confirm).then(function(result) {
                console.log(result)

                      result = result.replace(".","_")
                  var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                      db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                        ddd = doc


                        filename = get_filename_service.get_filename(doc,result,sibling_id=$scope.expression_id)
                        console.log(filename)

                        parent_id = get_parent_service.get_parent(doc, $scope.expression_id)

                        doc.tree_structure.push({
                          id:filename+"_68410298_"+time_string,
                          parent:parent_id,
                          text:filename,
                          icon:"fa fa-folder",
                          source:{
                            FUNCTION:'subsetting',
                            PARAMETER:{
                              data:$scope.expression_id,
                              sample_criterion:$scope.sample_column_option_criterions,
                              compound_criterion:$scope.compound_column_option_criterions
                            }
                          },
                          source_node_id:$scope.expression_id,
                          report:"subset"
                        })
                        doc.tree_structure.push({
                          id:filename+"_68410298_"+time_string+"_csv",
                          parent:filename+"_68410298_"+time_string,
                          text:filename+".csv",
                          icon:"fa fa-file-excel-o",
                          source:{
                            FUNCTION:'subsetting',
                            PARAMETER:{
                              data:$scope.expression_id,
                              sample_criterion:$scope.sample_column_option_criterions,
                              compound_criterion:$scope.compound_column_option_criterions
                            }
                          },
                          attname:filename+"_68410298_"+time_string+".csv",
                          source_node_id:filename+"_68410298_"+time_string,
                          type:"data_set"
                        })

                        doc['_attachments'][filename+"_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(csv)
                            }
                        doc['_attachments']["sample_info_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(p_csv)
                            }


                        db.put(doc).then(function(){
                               $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                               $scope.$apply(function(){
                                 $scope.saving = false;
                                 $scope.show_save = false;
                                 $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                               })
                            })

                      })
                }, function() {
                  $mdToast.show($mdToast.simple().textContent('canceled!').position('bottom right').hideDelay(3000));
                });
              };

            }


          })



        })

        })
    .controller("data_processing_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){




    })
    .controller("data_transformation_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){
      $scope.change_expression_id = function(){
        localStorage.setItem('activated_data_id', $scope.expression_id)
      }
      $scope.method_options = [
        'generalized log 10 transformation',
        'generalized log 2 transformation',
        'square root transformation',
        'cubic root transformation'
      ]
      $scope.method = 'generalized log 10 transformation'
      $scope.check_normality = true
      $scope.use_pca = true
      $scope.calculating = false
      $scope.table_ready = false
      $scope.table_options = {
        footerHeight: false,
        scrollbarV: true,
        headerHeight: 50,
        selectable: true,
        multiSelect: false,
        sortable:false,
        columnMode:"force",
        columns: [{
          name: "Name",
          prop: "name"
        }, {
          name: "Gender",
          prop: "gender"
        }, {
          name: "Company",
          prop: "company"
        }]
      };
      $http.get('js/100data.json').success(function(data) {
        $scope.table_data = data.splice(0, 10);
      });// for initializing the table.
      $scope.normality_check_ready = false
      $scope.pca_ready = false




      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                "expression_text":tree_structure[i].text
              })
            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.expression_id = localStorage.getItem('activated_data_id')
          $scope.study_design = doc.study_design

Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {p = results;
if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
}});


          $scope.submit = function(FUNCTION){
              $scope.show_save = false;
              $scope.calculating = true;
              var d = new Date();
                var time_string = d.getTime().toString()
                // change PARAMETER according to FUNCTION
                //var PARAMETER;
                PARAMETER = {
                          project_ID:localStorage.getItem("project_id_global"),
                          expression_id:localStorage.getItem("activated_data_id"),
                          method:$scope.method,
                          use_pca: $scope.use_pca,
                          check_normality:$scope.check_normality,
                          study_design:$scope.study_design
                        }
                $scope.table_ready = false
                $scope.normality_check_ready = false
                $scope.pca_ready = false
                var db_task = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task');

                var newtask_id = localStorage.getItem("username") + "_68410298_" + time_string
                  var new_task = {
                    "_id":newtask_id,
                    FUNCTION : FUNCTION,
                    PARAMETER: PARAMETER,
                    STATUS:"pending",PROJECT_ID:localStorage.getItem("project_id_global")
                  }
                  db_task.put(new_task).then(function(){
                    console.log("Task added: "+newtask_id)
                    var req = ocpu.call("CALCULATE_wrapper",{
                      task_id:newtask_id
                    },function(session){
                      $scope.show_save_result = true
                      sss = session
                      session.getObject(function(obj){
                        ooo = obj
                        var csv = Papa.unparse(obj.out.norm_data);
                        var options = []
                          for(var i=0; i<Object.keys(obj.out.table_data[0]).length; i++){
                            options.push({
                                    name: Object.keys(obj.out.table_data[0])[i],
                                    prop: Object.keys(obj.out.table_data[0])[i]
                                  })
                          }

                          $scope.$apply(function(){
                            $scope.table_options.columns = options
                            $scope.table_data = obj.out.table_data
                            $scope.refresh_table = function(){
                              $scope.table_data = obj.out.table_data;
                              hover_index = [];
                            }
                            $scope.table_ready = true
                            $scope.calculating = false;
                            $scope.show_save = true;
                          })
                          // check normality
                          if($scope.check_normality){
                            $scope.$apply(function(){
                                $scope.normality_check_ready = true
                                var before_num_normality = 0
                                for(var i=0;i<obj.out.before_normality.length;i++){
                                  if(obj.out.before_normality[i]>0.05){
                                    before_num_normality++
                                  }
                                }
                                var after_num_normality = 0
                                for(var i=0;i<obj.out.after_normality.length;i++){
                                  if(obj.out.after_normality[i]>0.05){
                                    after_num_normality++
                                  }
                                }
                                var improved_normality = 0
                                var worsen_normality = 0
                                for(var i=0;i<obj.out.normality_direction.length;i++){
                                  if(obj.out.normality_direction[i]>0){
                                    improved_normality++
                                  }else{
                                    worsen_normality++
                                  }
                                }
                                $scope.before_num_normality = before_num_normality
                                $scope.after_num_normality = after_num_normality
                                $scope.improved_normality = improved_normality
                                $scope.worsen_normality = worsen_normality


                                var data = [{
                                  type:'parcoords',
                                  pad:[80,80],
                                  line:{
                                    showscale: true,
                                    color:obj.out.normality_direction,
                                    cmin: Math.min(...obj.out.normality_direction),
                                    cmax: Math.max(...obj.out.normality_direction),
                                    colorscale: [['0', 'red'],['0.5','white'], ['1', 'green']]
                                  }
                                ,
                                dimensions:[{
                                  range:[0,1],
                                  label:'before transformation p value',
                                  values:obj.out.before_normality
                                },
                                {
                                  range:[0,1],
                                  label:'after transformation p value',
                                  values:obj.out.after_normality
                                }]
                                }]
                                var layout = {
                                  width:500
                                }
                                $timeout(function(){
                                  Plotly.plot('normality_check_plot', data, layout);
                                  var normality_check_plot = document.getElementById('normality_check_plot')
                                  hover_index = [];
                                  normality_check_plot.on('plotly_hover', function(data){
                                    if(hover_index.indexOf(data.curveNumber)===-1){ // if the hover data is not within the selected basket, add. Otherwise, ignore.
                                      hover_index.push(data.curveNumber)
                                    var hover_data=[]
                                    for(var i=0; i<hover_index.length;i++){
                                      hover_data.push(obj.out.table_data[hover_index[i]])
                                    }
                                    $scope.$apply(function(){$scope.table_data = hover_data;})
                                  //$scope.$apply(function(){$scope.table_data = [obj.out.table_data[data.curveNumber]]})
                                    }
                                  })
                                },10)
                              })
                          }
                          // pca
                          if($scope.use_pca){
                            $scope.$apply(function(){
                              $scope.pca_ready = true
                              if(typeof(doc.study_design)=='string'){
                                $scope.pca_button_text = doc.study_design
                              }else{
                                $scope.pca_button_text = doc.study_design[0]
                              }

                              $scope.toggle_pca_button_text = function(){

                                if(typeof(doc.study_design)=='string'){
                                  $scope.pca_button_text = doc.study_design
                                }else{

                                  if($scope.pca_button_text == doc.study_design[0]){
                                    $scope.pca_button_text = doc.study_design[1]
                                  }else{
                                    $scope.pca_button_text = doc.study_design[0]
                                  }
                                }


                              }

                              $scope.$watch("pca_button_text",function(){
                                var group = p.data.map(x => x[$scope.pca_button_text])
                                var unique_group = group.filter(unique)
                                before_data = [];
                                for(var i=0; i<unique_group.length;i++){
                                  before_data.push({
                                    x:getAllIndexes(group,unique_group[i]).map(ind => obj.out.before_pca_score[ind][0]),
                                    y:getAllIndexes(group,unique_group[i]).map(ind => obj.out.before_pca_score[ind][1]),
                                    mode:'markers+text',
                                    type:'scatter',
                                    name:unique_group[i],
                                    text:getAllIndexes(group,unique_group[i]).map(ind => p.data[ind].label),
                                    textposition:'top center'
                                  })
                                }
                                after_data = [];
                                for(var i=0; i<unique_group.length;i++){
                                  after_data.push({
                                    x:getAllIndexes(group,unique_group[i]).map(ind => obj.out.after_pca_score[ind][0]),
                                    y:getAllIndexes(group,unique_group[i]).map(ind => obj.out.after_pca_score[ind][1]),
                                    mode:'markers+text',
                                    type:'scatter',
                                    name:unique_group[i],
                                    text:getAllIndexes(group,unique_group[i]).map(ind => p.data[ind].label),
                                    textposition:'top center'
                                  })
                                }
                                var before_layout = {
                                      title:'Before Transformation'
                                    };
                                var after_layout = {
                                      title:'After Transformation'
                                    };
                                $timeout(function(){
                                  Plotly.newPlot('before_pca', before_data, before_layout);
                                  Plotly.newPlot('after_pca', after_data, after_layout);
                                },1)

                              },true)

                            })
                          }





                        $scope.save_result = function(){
                          var  p_csv = Papa.unparse(p.data);
                          $scope.saving = true
                          var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                          db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                            dd = doc

                            filename = get_filename_service.get_filename(doc,$scope.method,sibling_id=PARAMETER.expression_id)

                            var parent_id = get_parent_service.get_parent(doc, PARAMETER.expression_id)

                            doc.tree_structure.push({
                              id:filename+"_68410298_"+time_string,
                              parent:parent_id,
                              text:filename,
                              icon:"fa fa-folder",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              source_node_id:PARAMETER.expression_id,
                              report:obj.out.report_text[0]
                            })
                            doc.tree_structure.push({
                              id:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+"_csv",
                              parent:filename+"_68410298_"+time_string,
                              text:$scope.method+".csv",
                              icon:"fa fa-file-excel-o",
                              source:{
                                FUNCTION:FUNCTION,
                                PARAMETER:PARAMETER
                              },
                              attname:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv",
                              source_node_id:filename+"_68410298_"+time_string,
                              type:"data_set"
                            })

                            doc['_attachments'][$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(csv)
                            }
                            doc['_attachments']["sample_info_68410298_"+time_string+".csv"] = {
                              content_type:"application/vnd.ms-excel",
                              "data": btoa(p_csv)
                            }


                            db.put(doc).then(function(){
                               $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                               $scope.$apply(function(){
                                 $scope.saving = false;
                                 $scope.show_save = false;
                                 $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                               })
                            })
                          })
                        }
                      })
                    }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
                  })
            }
        })
      })

    })
    .controller("sample_normalization_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){
      $scope.change_expression_id = function(){
        localStorage.setItem('activated_data_id', $scope.expression_id)
      }
      $scope.method_options = [
        'generalized log 10 transformation',
        'generalized log 2 transformation',
        'square root transformation',
        'cubic root transformation'
      ]
      $scope.method = 'generalized log 10 transformation'



    })
    .controller("visualization_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){
          $scope.change_expression_id = function(){
            localStorage.setItem('activated_data_id', $scope.expression_id)
          }
      $scope.two_factor = false
      $scope.calculating = false
      $scope.add_error_bar = true


      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                "expression_text":tree_structure[i].text
              })
            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.expression_id = localStorage.getItem('activated_data_id')
          $scope.study_design = doc.study_design
          $scope.factor1_options = doc.sample_info_column_name
          $scope.factor2_options = doc.sample_info_column_name
          if(typeof(doc.study_design)=='string'){
            $scope.two_factor = false
            $scope.factor1=doc.study_design
          }else{
            $scope.two_factor = true
            $scope.factor1=doc.study_design[0]
            $scope.factor2=doc.study_design[1]
          }
          $scope.$watch("factor1",function(value){
            $scope.levels1_options = doc.sample_info[value]
            $scope.levels1 = doc.sample_info[value]
          })
          $scope.$watch("factor2",function(value){
            $scope.levels2_options = doc.sample_info[value]
            $scope.levels2 = doc.sample_info[value]
          })
        })
      })


      $scope.submit = function(FUNCTION){
        $scope.calculating = true
        var d = new Date();
        var time_string = d.getTime().toString()
          // change PARAMETER according to FUNCTION
          //var PARAMETER;
          switch (FUNCTION) {
              case "boxplot":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    factor1:$scope.factor1,
                    levels1:$scope.levels1,
                    two_factor:$scope.two_factor,
                    factor2:$scope.factor2,
                    levels2:$scope.levels2
                  }
                  break;
              case "barplot":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    factor1:$scope.factor1,
                    levels1:$scope.levels1,
                    two_factor:$scope.two_factor,
                    factor2:$scope.factor2,
                    levels2:$scope.levels2
                  }
                  break;
              case "linechart":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    factor1:$scope.factor1,
                    levels1:$scope.levels1,
                    two_factor:$scope.two_factor,
                    factor2:$scope.factor2,
                    levels2:$scope.levels2
                  }
                  break;
              case 'others':
                  PARAMETER = {}
          }


          Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+localStorage.getItem("activated_data_id").replace("_csv",".csv"), {header: true,download: true,complete: function(results) {

            e = results;
            if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
              e.data.pop();
            }
          }});
Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {p = results;
if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
}});

          datas = []
          labels = []
          plot_data = []
          var db_task = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task');

          var newtask_id = localStorage.getItem("username") + "_68410298_" + time_string
            var new_task = {
              "_id":newtask_id,
              FUNCTION : FUNCTION,
              PARAMETER: PARAMETER,
              STATUS:"pending",PROJECT_ID:localStorage.getItem("project_id_global")
            }
            db_task.put(new_task).then(function(){
              console.log("Task added: "+newtask_id)

                if(!$scope.two_factor){
                    var factor1 = PARAMETER.factor1
                    var group=[];
                    for(var i=0;i<p.data.length;i++){
                      if(PARAMETER.levels1.indexOf(p.data[i][factor1])!==-1){
                        group.push(p.data[i][factor1])
                      }
                    }

                    for(var j=0;j<e.data.length;j++){//
                      var dta = e.data[j]
                      var data=[]
                      for(var i=0; i<PARAMETER.levels1.length;i++){
                        data.push({
                          y:[],
                          name : PARAMETER.levels1[i],
                          type:"box",
                          boxpoints: 'all'
                        })
                      }
                      for(var i=0;i<group.length;i++){
                        data[PARAMETER.levels1.indexOf(group[i])].y.push(
                          dta[Object.keys(dta)[i+1]]
                        )

                      }

                      if($scope.$state.current.data.function_name == 'barplot'||$scope.$state.current.data.function_name == 'linechart'){
                        var data_bar = {
                          x:[],
                          y:[],
                          type:($scope.$state.current.data.function_name == 'barplot')? 'bar':'scatter'
                        };
                        if($scope.add_error_bar){
                            data_bar.error_y = {array:[]}
                        }
                        for(var i=0;i<data.length;i++){
                          var mean = ss.mean(data[i].y.map(Number))
                          data_bar.x.push(data[i].name);data_bar.y.push(mean);
                          if($scope.add_error_bar){
                            data_bar.error_y.array.push(1.96*(ss.standardDeviation(data[i].y.map(Number))/Math.sqrt(data[i].y.length) ))
                          }

                        }
                        data = [data_bar]
                      }

                      labels.push(dta.label)
                      datas.push(data)

                    }
                    var index = 0
                    var test = []
                    var layout = {
                        title: labels[0],
                        yaxis: {
                          title: 'data value',
                          zeroline: false
                        },
                        boxmode: 'group',
                        height:500
                      }
                    Plotly.newPlot(graph, datas[0], layout).then(function(){
                      var calculate_loop = setInterval(function(){
                        if(index==datas.length){
                          $scope.$apply(function(){$scope.show_save_result = true;$scope.calculating = false})
                          clearInterval(calculate_loop);
                        }else{
                          var update_data_y = []
                          var update_data_error_bar = []
                          var restyle_index = []
                          if($scope.$state.current.data.function_name == 'barplot'||$scope.$state.current.data.function_name == 'linechart'){
                            update_data_y.push(datas[index][0].y)
                            if($scope.add_error_bar){
                              update_data_error_bar.push(datas[index][0].error_y)
                            }
                          }else if($scope.$state.current.data.function_name == 'boxplot'){
                            for(var i=0; i<PARAMETER.levels1.length;i++){
                              update_data_y.push(datas[index][i].y)
                              restyle_index.push(i)
                            }
                          }

                          var update_data = {
                            y:update_data_y
                          }
                          if($scope.add_error_bar){
                            update_data.error_y = update_data_error_bar
                          }
                          var update_layout = {
                            title:labels[index]
                          }
                          Plotly.relayout(graph, update_layout)
                          Plotly.restyle(graph, update_data, restyle_index).then(
                            function(gd)
                             {
                              Plotly.toImage(gd,{height:600,width:800})
                                 .then(
                                    function(url)
                                 {
                                    plot_data.push(url.split("base64,")[1])
                                 }
                                 )
                          });
                          index++;
                        }
                      },10)
                    })




                }else{


                        var factor1 = PARAMETER.factor1
                        var group1=[];
                        var factor2 = PARAMETER.factor2
                        var group2=[];
                        for(var i=0;i<p.data.length;i++){
                          if(PARAMETER.levels1.indexOf(p.data[i][factor1])!==-1 && PARAMETER.levels2.indexOf(p.data[i][factor2])!==-1){
                            group1.push(p.data[i][factor1])
                            group2.push(p.data[i][factor2])
                          }
                        }





                        for(var j=0; j<e.data.length;j++){//
                          var dta  = e.data[j]
                          var data=[]
                          for(var i=0; i<PARAMETER.levels2.length;i++){
                            data.push({
                              y:[],
                              x:[],
                              name : PARAMETER.levels2[i],
                              type:"box",
                              boxpoints: 'all'
                            })
                          }
                          for(var i=0;i<group2.length;i++){
                            data[PARAMETER.levels2.indexOf(group2[i])].y.push(
                              dta[Object.keys(dta)[i+1]]
                            )
                            data[PARAMETER.levels2.indexOf(group2[i])].x.push(
                              group1[i]
                            )
                          }



                          if($scope.$state.current.data.function_name == 'barplot'||$scope.$state.current.data.function_name == 'linechart'){
                            var data_bar = []
                            for(var i=0;i<data.length;i++){

                              var indexes = PARAMETER.levels1.map(x => getAllIndexes(data[i].x,x))
                              var ys = indexes.map(function(x){
                                return x.map(j => data[i].y[j])
                              })
                              data_bar.push({
                                x:PARAMETER.levels1,
                                y:ys.map(y => ss.mean(y.map(Number))),
                                name:data[i].name,
                                type:($scope.$state.current.data.function_name == 'barplot')? 'bar':'scatter'
                              })
                              if($scope.add_error_bar){
                                data_bar[i].error_y = {array:ys.map(y => 1.96*(ss.standardDeviation(y.map(Number))/Math.sqrt(y.length) ))}
                              }
                            }

                            data = data_bar

                          }

                          labels.push(dta.label)
                          datas.push(data)
                        }
                        var index = 1
                        var test = []
                        var layout = {
                            title: labels[0],
                            yaxis: {
                              title: 'data value',
                              zeroline: false
                            },
                            boxmode: 'group',
                            height:500
                          }
                        Plotly.newPlot(graph, datas[0], layout).then(function(){
                          var calculate_loop = setInterval(function(){
                            if(index==datas.length){
                              $scope.$apply(function(){$scope.show_save_result = true;$scope.calculating = false})
                              clearInterval(calculate_loop);
                            }else{
                              var update_data_y = []
                              var restyle_index = []
                              var update_data_error_bar = []

                              if($scope.$state.current.data.function_name=='boxplot'){
                                for(var i=0; i<PARAMETER.levels2.length;i++){
                                  update_data_y.push(datas[index][i].y)
                                  restyle_index.push(i)
                                }
                              }else if($scope.$state.current.data.function_name == 'barplot'||$scope.$state.current.data.function_name == 'linechart'){
                                for(var i=0; i<PARAMETER.levels2.length;i++){
                                  update_data_y.push(datas[index][i].y)
                                  restyle_index.push(i)
                                  if($scope.add_error_bar){
                                    update_data_error_bar.push(datas[index][i].error_y)
                                  }
                                }
                              }

                              var update_data = {
                                y:update_data_y
                              }
                              if($scope.add_error_bar){
                                update_data.error_y=update_data_error_bar
                              }

                              var update_layout = {
                                title:labels[index]
                              }
                              Plotly.relayout(graph, update_layout)
                              Plotly.restyle(graph, update_data, restyle_index).then(
                                function(gd)
                                 {
                                  Plotly.toImage(gd,{height:600,width:800})
                                     .then(
                                        function(url)
                                     {
                                        plot_data.push(url.split("base64,")[1])
                                     }
                                     )
                              });
                              index++;
                            }
                          },10)
                        })


                }
                $scope.save_result = function(){
                    $scope.saving = true
                    var zip = new JSZip();
                    for(var i=0;i<datas.length;i++){
                      zip.file("No"+i+"_"+labels[i]+".png", plot_data[i], {base64: true});
                    }
                    zip.generateAsync({type:"base64"}).then(function (base64) {

                      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                      db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){

                        dd = doc

                        filename = get_filename_service.get_filename(doc,$scope.$state.current.data.pageTitle,sibling_id=PARAMETER.expression_id)

                        var parent_id = get_parent_service.get_parent(doc, PARAMETER.expression_id)

                        doc.tree_structure.push({
                          id:filename+"_68410298_"+time_string,
                          parent:parent_id,
                          text:filename,
                          icon:"fa fa-folder",
                          source:{
                            FUNCTION:FUNCTION,
                            PARAMETER:PARAMETER
                          },
                          source_node_id:PARAMETER.expression_id,
                          report:"boxplot generated"
                        })
                        doc.tree_structure.push({
                          id:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+"_zip",
                          parent:filename+"_68410298_"+time_string,
                          text:$scope.$state.current.data.pageTitle+".zip",
                          icon:"fa fa-file-zip-o",
                          source:{
                            FUNCTION:FUNCTION,
                            PARAMETER:PARAMETER
                          },
                          attname:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".zip",
                          source_node_id:filename+"_68410298_"+time_string
                        })

                        doc['_attachments'][$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".zip"] = {
                          content_type:"application/x-zip-compressed",
                          "data": base64
                        }

                        db.put(doc).then(function(){
                           $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                           $scope.$apply(function(){
                             $scope.saving = false;
                             $scope.show_save_result = false;
                             $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                           })
                        })
                      })

                    })

                }

            })
      }


    })
    .controller("boxplot_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){

    })
    .controller("bar_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){

    })
    .controller("linechart_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){

    })
    .controller("bimo_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){

    })
    .controller("bimo_scatter_plot_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){
      //var data_being_used;
      $.get("http://ipinfo.io", function(response) {ip = response.ip;
        if(ip === "128.120.143.234"){
          $scope.admin = true
        }
      }, "jsonp");


      //var saved_plot_data;
      //var saved_plot_layout;
      //var saved_plot_data_ellipse;

      $scope.show_axis = false
      $scope.by_column = true
      $scope.add_confidence_interval = true
      $scope.group_data_into_tarces = true;
      $scope.confidence_grouping = true;
      $scope.confidence_type = "Ellipse"

      var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');
      db_user_info.get(localStorage.getItem("username")).then(function(doc){
        saved_plot_data = doc.saved_plot_data
        saved_plot_layout = doc.saved_plot_layout
        saved_plot_data_ellipse = doc.saved_plot_data_ellipse
      })


              // initialized selection options.
              $scope.textposition_options = [
                "top left","top center","top right",
                 "middle left","middle center","middle right" ,
                "bottom left","bottom center","bottom right"
              ]
              $scope.family_options = [
                "Arial", "Balto", "Courier New", "Droid Sans",, "Droid Serif", "Droid Sans Mono", "Gravitas One", "Old Standard TT", "Open Sans", "Overpass", "PT Sans Narrow", "Raleway", "Times New Roman"
              ]
              $scope.fill_options = [
                'none',"tozeroy","tozerox","tonexty","tonextx","toself","tonext"
              ]
              $scope.symbol_options = [
                 "circle" , "circle-open", "circle-dot" , "circle-open-dot" , "square" , "square-open" , "square-dot" ,  "square-open-dot" , "diamond" , "diamond-open" , "diamond-dot" ,"diamond-open-dot", "cross" ,  "cross-open" ,  "cross-dot" ,"cross-open-dot" , "x" , "x-open", "x-dot" , "x-open-dot", "triangle-up" , "triangle-up-open" ,"triangle-up-dot" , "triangle-up-open-dot" , "triangle-down" ,  "triangle-down-open" ,  "triangle-down-dot" , "triangle-down-open-dot" , "triangle-left" ,"triangle-left-open" , "triangle-left-dot" ,  "triangle-left-open-dot" ,"triangle-right" , "triangle-right-open" ,"triangle-right-dot" , "triangle-right-open-dot" ,"triangle-ne" ,"triangle-ne-open" , "triangle-ne-dot" , "triangle-ne-open-dot" ,  "triangle-se" ,  "triangle-se-open" , "triangle-se-dot" ,"triangle-se-open-dot" , "triangle-sw" , "triangle-sw-open" , "triangle-sw-dot" ,"triangle-sw-open-dot" ,"triangle-nw" ,"triangle-nw-open" , "triangle-nw-dot" , "triangle-nw-open-dot" , "pentagon" ,"pentagon-open" , "pentagon-dot" , "pentagon-open-dot" , "hexagon" , "hexagon-open" ,"hexagon-dot" ,"hexagon-open-dot" ,"hexagon2" , "hexagon2-open" , "hexagon2-dot" , "hexagon2-open-dot" ,  "octagon" , "octagon-open" ,"octagon-dot" , "octagon-open-dot" , "star" , "star-open"  , "star-dot" ,  "star-open-dot" ,  "hexagram" , "hexagram-open" , "hexagram-dot" , "hexagram-open-dot" , "star-triangle-up" , "star-triangle-up-open" , "star-triangle-up-dot" ,"star-triangle-up-open-dot" , "star-triangle-down" ,  "star-triangle-down-open" , "star-triangle-down-dot" ,"star-triangle-down-open-dot" , "star-square" ,  "star-square-open" , "star-square-dot" , "star-square-open-dot" ,"star-diamond" , "star-diamond-open" , "star-diamond-dot" ,  "star-diamond-open-dot" , "diamond-tall" , "diamond-tall-open" , "diamond-tall-dot" , "diamond-tall-open-dot" ,"diamond-wide" , "diamond-wide-open" ,"diamond-wide-dot" , "diamond-wide-open-dot" ,  "hourglass" ,"hourglass-open" , "bowtie" ,  "bowtie-open" , "circle-cross" ,"circle-cross-open" , "circle-x" ,  "circle-x-open" , "square-cross" , "square-cross-open" , "square-x" , "square-x-open" ,  "diamond-cross" ,"diamond-cross-open" ,"diamond-x" ,"diamond-x-open" , "cross-thin" ,"cross-thin-open" , "x-thin" , "x-thin-open" , "asterisk" ,  "asterisk-open" ,"hash" ,"hash-open" , "hash-dot" , "hash-open-dot"  , "y-up" , "y-up-open", "y-down" , "y-down-open", "y-left" , "y-left-open" , "y-right" ,"y-right-open" ,"line-ew" ,"line-ew-open"  , "line-ns" , "line-ns-open" ,  "line-ne" , "line-ne-open" , "line-nw" , "line-nw-open"
              ]

      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].attname !== undefined){
              if(tree_structure[i].attname.indexOf(".csv")!==-1){
                expression_id_options.push({
                  "expression_id":tree_structure[i].id,
                  "expression_text":tree_structure[i].text
                })
              }
            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options




          $scope.upload_file = function(){

            data_being_used = $scope.expression_id

            Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+$scope.expression_id.replace("_csv",".csv"), {header: true,download: true,complete: function(results) {
              data = results;
              if($scope.expression_id.indexOf("expression_data")!==-1){
                data.data.pop();
              }
              $scope.$apply(function(){
                $scope.show_axis = true
                $scope.$watch("by_column",function(newValue, oldValue){
                    if($scope.by_column){
                      $scope.x_axis_options = Object.keys(data.data[0])
                      $scope.x_axis = Object.keys(data.data[0])[0]
                      $scope.y_axis_options = Object.keys(data.data[0])
                      $scope.y_axis = Object.keys(data.data[0])[1]
                    }else{
                      $scope.x_axis_options = data.data.map(d => d.label)
                      $scope.x_axis = $scope.x_axis_options[0]
                      $scope.y_axis_options = data.data.map(d => d.label)
                      $scope.y_axis = $scope.y_axis_options[1]
                    }
                },true)
              })
            }});
            $scope.show_upload_button = false
            $scope.show_submit_data_setting_button = true
            $scope.$watch("group_data",function(){
              if($scope.group_data !== undefined){
                Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+$scope.group_data.replace("_csv",".csv"), {header: true,download: true,complete: function(result) {
                  group_data = result;group_data.data.pop();
                  $scope.group_data_column_options = Object.keys(group_data.data[0])
                  $scope.group_data_column = $scope.group_data_column_options[0]
                }})
              }
            },true)
            $scope.$watch("ellipse_group_data",function(){
              if($scope.ellipse_group_data !== undefined){
                Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+$scope.ellipse_group_data.replace("_csv",".csv"), {header: true,download: true,complete: function(result) {
                  ellipse_group_data = result;ellipse_group_data.data.pop();
                  $scope.ellipse_group_data_column_options = Object.keys(ellipse_group_data.data[0])
                  $scope.ellipse_group_data_column = $scope.ellipse_group_data_column_options[0]
                }})
              }
            },true)

          }

          $scope.submit_data_setting = function(){
            // get x axis and y axis value.
              if($scope.by_column){
                x = data.data.map(d => Number(d[$scope.x_axis]))
                y = data.data.map(d => Number(d[$scope.y_axis]))
                label = data.data.map(d => d.label)
              }else{
                x=[];y=[];
                for(var i=0; i<data.data.length;i++){
                  if(data.data[i].label == $scope.x_axis){
                    x = Object.values(data.data[i]); break;
                  }
                };x.splice(0,1);x.map(val => Number(val))
                for(var i=0; i<data.data.length;i++){
                  if(data.data[i].label == $scope.y_axis){
                    y = Object.values(data.data[i]); break;
                  }
                };y.splice(0,1);y.map(val => Number(val))
                label=Object.keys(data.data[0]);label.splice(0,1);
              }

              if($scope.group_data_into_tarces){
                group = [];
                for(var i=0; i<group_data.data.length;i++){
                  if(label.indexOf(group_data.data[i].label)!==-1){
                    group.push(group_data.data[i][$scope.group_data_column])
                  }
                }
              }else{
                group = Array(label.length).fill('data')
              }
              // add ellipse
              if($scope.confidence_grouping){
                ellipse_group = group
              }else{
                Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+$scope.ellipse_group_data.replace("_csv",".csv"), {header: true,download: true,complete: function(results) {
                  ellipse_data = results;
                  if($scope.expression_id.indexOf("expression_data")!==-1){
                    ellipse_data.data.pop();
                  }
                  ellipse_group = ellipse_data.data.map(d => d[$scope.ellipse_group_data_column])
                }});
              }

              var interval = setInterval(function(){
                if(typeof(ellipse_group) !== 'undefined'){
                  clearInterval(interval);
                  var req = ocpu.call("calculate_ellipse",{
                    x:x,
                    y:y,
                    group:ellipse_group
                  },function(session){
                    session.getObject(function(obj){

                      $scope.$apply(function(){
                        // initialize the data and layout parameters.
                        time = 1
                        //plot_data = []
                        group_levels = group.filter(unique)
                        plot_data = saved_plot_data.slice(0, group_levels.length)
                        xaxis_range_min = Math.min(Math.min(...obj.ellipse.map(function(val){return val.map(v => v[0])}).map(v => Math.min(...v))) * 0.9,Math.min(...obj.ellipse.map(function(val){return val.map(v => v[0])}).map(v => Math.min(...v))) * 1.1)
                        xaxis_range_max = Math.max(Math.max(...obj.ellipse.map(function(val){return val.map(v => v[0])}).map(v => Math.max(...v))) * 0.9,Math.max(...obj.ellipse.map(function(val){return val.map(v => v[0])}).map(v => Math.max(...v))) * 1.1)
                        yaxis_range_min = Math.min(Math.min(...obj.ellipse.map(function(val){return val.map(v => v[1])}).map(v => Math.min(...v))) * 0.9,Math.min(...obj.ellipse.map(function(val){return val.map(v => v[1])}).map(v => Math.min(...v))) * 1.1)
                        yaxis_range_max = Math.max(Math.max(...obj.ellipse.map(function(val){return val.map(v => v[1])}).map(v => Math.max(...v))) * 0.9,Math.max(...obj.ellipse.map(function(val){return val.map(v => v[1])}).map(v => Math.max(...v))) * 1.1)
                        for(var i=0;i<group_levels.length;i++){
                          index = getAllIndexes(group, group_levels[i])
                          if(plot_data[i] === undefined){
                            plot_data.push({
                              x: index.map(i => x[i]),
                              y: index.map(i => y[i]),
                              type: 'scatter', // set
                              legendgroup:group_levels[i],
                              name: group_levels[i],
                              mode: saved_plot_data[i] ? saved_plot_data[i].mode :'markers+text', // markers, text, markers+text
                              text: index.map(i => label[i]), // whem mode is text
                              textposition:saved_plot_data[i] ? saved_plot_data[i].textposition : "top center",// whem mode is text
                              textfont:{
                                family:saved_plot_data[i] ? saved_plot_data[i].textfont.family : "Arial",
                                size:saved_plot_data[i] ? saved_plot_data[i].textfont.size : 12*time,
                                color:saved_plot_data[i] ? saved_plot_data[i].textfont.color:"#00ff00"
                              }, // whem mode is text
                              marker: {
                                symbol:saved_plot_data[i]? saved_plot_data[i].marker.symbol:"circle",
                                color: saved_plot_data[i]? saved_plot_data[i].marker.color: '#ff69b4',
                                opacity:saved_plot_data[i]? saved_plot_data[i].marker.opacity:1,
                                size:saved_plot_data[i]? saved_plot_data[i].marker.size: 12*time,
                                colorscale:saved_plot_data[i]? saved_plot_data[i].marker.colorscale:'Greys',// use the palette when color is a continuous numeric input NOT READY!
                                showscale:saved_plot_data[i]? saved_plot_data[i].marker.showscale:false,// use the palette when color is a continuous numeric input NOT READY!
                                colorbar:{
                                  thicknessmode:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.thicknessmode:"pixels",//set
                                  thickness:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.thickness:100*time,
                                  lenmode:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.lenmode:'pixels',//set
                                  len:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.len:400*time,
                                  x:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.x:1, // positino of colorbar -2 ~ 3
                                  xanchor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.xanchor:"left",// x relative to colorbar
                                  xpad:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.xpad:20*time,
                                  y:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.y:0.5, // -2 ~ 3
                                  yanchor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.yanchor:"top",
                                  ypad:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.ypad:10*time,
                                  outlinecolor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.outlinecolor:"green",
                                  outlinewidth:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.outlinewidth:2*time,
                                  bordercolor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.bordercolor:"red",
                                  borderwidth:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.borderwidth:2*time,
                                  bgcolor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.bgcolor:"yellow",
                                  tickmode:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickmode:"array", // auto or array
                                  nticks:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.nticks:6, // when tickmode auto
                                  tickvals:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickvals:[1,2],// when tickmode array
                                  ticktext:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.ticktext:[1,20],// when tickmode array
                                  ticks:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.ticks:"outside",
                                  ticklen:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.ticklen:12*time, // when ticks is not ""
                                  tickwidth:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickwidth:12*time,
                                  tickcolor:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickcolor:"red",
                                  showticklabels:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.showticklabels:true,
                                  tickfont:{
                                    family:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickfont.family:"Arial",
                                    size:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickfont.size:16*time,
                                    color:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickfont.color:"green"
                                  },// when showticklabels
                                  tickangle:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.tickangle:45,// when showticklabels
                                  title:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.title:"right",
                                  titlefont:{
                                    family:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.titlefont.family:"Arial",
                                    size:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.titlefont.size:15*time,
                                    color:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.titlefont.color:"blue"
                                  },
                                  titleside:saved_plot_data[i]? saved_plot_data[i].marker.colorbar.titleside:"right"
                                },// use the palette when color is a continuous numeric input
                                line:{// symbol -open not ok
                                  width:saved_plot_data[i]? saved_plot_data[i].marker.line.width:1*time,
                                  color:saved_plot_data[i]? saved_plot_data[i].marker.line.color:"#000000"
                                }
                              },
                              fill:saved_plot_data[i]? saved_plot_data[i].fill:"none",
                              fillcolor:saved_plot_data[i]? saved_plot_data[i].fillcolor:'#ffffff'// when fill is not 'none'
                            })
                          }else{
                            plot_data[i].x = index.map(i=>x[i])
                            plot_data[i].y = index.map(i=>y[i])
                            plot_data[i].legendgroup = group_levels[i]
                            plot_data[i].name = group_levels[i]
                            plot_data[i].text = index.map(i => label[i])
                          }
                        }
                        $scope.plot_data = plot_data


                        plot_layout = saved_plot_layout
                        plot_layout.xaxis.range = [xaxis_range_min,xaxis_range_max]
                        plot_layout.yaxis.range = [yaxis_range_min,yaxis_range_max]
                        $scope.plot_layout = plot_layout


                        $scope.group_levels = group_levels
                        $scope.show_result = true
                        jjj = obj
                        //plot_data_ellipse=[];
                        plot_data_ellipse = saved_plot_data_ellipse.slice(0, obj.ellipse.length)
                        for(var i=0;i<obj.ellipse.length;i++){
                          if(plot_data_ellipse[i] === undefined){
                            plot_data_ellipse.push({
                            x:obj.ellipse[i].map(val => val[0]),
                            y:obj.ellipse[i].map(val => val[1]),
                            type:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].type:'scatter',
                            show_ellipse:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].show_ellipse:true,
                            legendgroup:group_levels[i],
                            name:group_levels[i] + "-ellipse",
                            mode:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].mode:"lines",
                            fill:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].fill:'toself',
                            plot_data_ellipse_fillcolor:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].plot_data_ellipse_fillcolor:'#ff69b4',
                            plot_data_ellipse_fillcolor_opacity:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].plot_data_ellipse_fillcolor_opacity:0.3,
                            fillcolor:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].fillcolor:hexToRgb('#ff69b4',0.3),
                            opacity:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].opacity:0.3,
                            line:{
                              width:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].line.width:1*time,
                              color:saved_plot_data_ellipse[i] ? saved_plot_data_ellipse[i].line.color:'#ff69b4'
                            },
                            showlegend:true
                          })
                          }else{
                            plot_data_ellipse[i].x = obj.ellipse[i].map(val => val[0])
                            plot_data_ellipse[i].y = obj.ellipse[i].map(val => val[1])
                            plot_data_ellipse[i].legendgroup = group_levels[i]
                            plot_data_ellipse[i].name = group_levels[i] + "-ellipse"
                          }

                        }
                        $scope.plot_data_ellipse_fillcolor_transformation = function(i){
                          $scope.plot_data_ellipse[i].fillcolor = hexToRgb($scope.plot_data_ellipse[i].plot_data_ellipse_fillcolor,$scope.plot_data_ellipse[i].plot_data_ellipse_fillcolor_opacity)
                        }
                        $scope.update_range = function(){
                          $scope.plot_layout.xaxis.range = [$scope.plot_layout.xaxis.xaxis_range_min, $scope.plot_layout.xaxis.xaxis_range_max]
                          $scope.plot_layout.yaxis.range = [$scope.plot_layout.yaxis.yaxis_range_min, $scope.plot_layout.yaxis.yaxis_range_max]
                        }
                        $scope.plot_data_ellipse = plot_data_ellipse
                        previous_line_width = plot_data_ellipse[0].line.width
                        previous_fill = plot_data_ellipse[0].fill
                        $scope.toggle_ellipse = function(i){
                          if(!$scope.plot_data_ellipse[i].show_ellipse){
                            $scope.previous_line_width = plot_data_ellipse[i].line.width
                            $scope.previous_fill = plot_data_ellipse[i].fill
                            $scope.plot_data_ellipse[i].line.width=0
                            $scope.plot_data_ellipse[i].fill="none"
                            $scope.plot_data_ellipse[i].showlegend=false
                          }else{
                            $scope.plot_data_ellipse[i].line.width=previous_line_width
                            $scope.plot_data_ellipse[i].fill=previous_fill
                            $scope.plot_data_ellipse[i].showlegend=true
                          }
                        }
                        $scope.format_mirror_x = function(){
                          if($scope.plot_layout.xaxis.mirror_unformated == "true"){
                            $scope.plot_layout.xaxis.mirror = true
                          }else if($scope.plot_layout.xaxis.mirror_unformated == "false"){
                            $scope.plot_layout.xaxis.mirror = false
                          }else{
                            $scope.plot_layout.xaxis.mirror = "ticks"
                          }
                        }
                        $scope.format_mirror_y = function(){
                          if($scope.plot_layout.yaxis.mirror_unformated == "true"){
                            $scope.plot_layout.yaxis.mirror = true
                          }else if($scope.plot_layout.yaxis.mirror_unformated == "false"){
                            $scope.plot_layout.yaxis.mirror = false
                          }else{
                            $scope.plot_layout.yaxis.mirror = "ticks"
                          }
                        }

                        $scope.save_attribute = function(){
                          var db_user_info = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_user_info');
                          db_user_info.get(localStorage.getItem("username")).then(function(doc){
                            dd = doc
                            doc.saved_plot_data = $scope.plot_data
                            doc.saved_plot_layout = $scope.plot_layout
                            doc.saved_plot_data_ellipse = $scope.plot_data_ellipse
                            db_user_info.put(doc).then(function(){
                              $mdToast.show($mdToast.simple().textContent('The plot attributes have been saved!').position('bottom right').hideDelay(3000));
                            })
                          })
                        }

                        $rootScope.$on('load_selected_style', function(event, args) {

                          var styles_db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/bimo');
                              styles_db.get("scatter plot styles").then(function(doc){
                          for(var i = 0; i<styles.length;i++){
                            if(styles[i].plot_id == args){
                              selected_style = styles[i]; break;
                            }
                          }


                          for(var j=0;j<group_levels.length;j++){
                            index = getAllIndexes(group, group_levels[j])
                            if(selected_style.plot_data[j] !== undefined){
                              selected_style.plot_data[j].x = index.map(k=>x[k])
                              selected_style.plot_data[j].y = index.map(k=>y[k])
                              selected_style.plot_data[j].text = index.map(k => label[k])
                              selected_style.plot_data[j].name = group_levels[j]
                              selected_style.plot_data[j].legendgroup = group_levels[j]
                            }else{
                              selected_style.plot_data[j] = JSON.parse(JSON.stringify(doc.default_style_plot_data))
                              selected_style.plot_data[j].x = index.map(k=>x[k])
                              selected_style.plot_data[j].y = index.map(k=>y[k])
                              selected_style.plot_data[j].text = index.map(k => label[k])
                              selected_style.plot_data[j].name = group_levels[j]
                              selected_style.plot_data[j].legendgroup = group_levels[j]
                            }

                           }
                          $scope.plot_data = selected_style.plot_data.slice(0,group_levels.length)
                          for(var j=0;j<obj.ellipse.length;j++){
                            if(selected_style.plot_data_ellipse[j] !== undefined){
                              selected_style.plot_data_ellipse[j].x = obj.ellipse[j].map(val => val[0])
                              selected_style.plot_data_ellipse[j].y = obj.ellipse[j].map(val => val[1])
                              selected_style.plot_data_ellipse[j].name = group_levels[j]
                              selected_style.plot_data_ellipse[j].legendgroup = group_levels[j]
                            }else{
                              selected_style.plot_data_ellipse[j] = JSON.parse(JSON.stringify(doc.default_style_plot_data_ellipse))
                              selected_style.plot_data_ellipse[j].x = obj.ellipse[j].map(val => val[0])
                              selected_style.plot_data_ellipse[j].y = obj.ellipse[j].map(val => val[1])
                              selected_style.plot_data_ellipse[j].name = group_levels[j]
                              selected_style.plot_data_ellipse[j].legendgroup = group_levels[j]
                            }
                           }
                          $scope.plot_data_ellipse = selected_style.plot_data_ellipse.slice(0,obj.ellipse.length)


                          selected_style.plot_layout.xaxis.xaxis_range_min = xaxis_range_min
                          selected_style.plot_layout.xaxis.xaxis_range_max = xaxis_range_max
                          selected_style.plot_layout.yaxis.yaxis_range_min = yaxis_range_min
                          selected_style.plot_layout.yaxis.yaxis_range_max = yaxis_range_max
                          selected_style.plot_layout.xaxis.range = [xaxis_range_min, xaxis_range_max]
                          selected_style.plot_layout.yaxis.range = [yaxis_range_min, yaxis_range_max]

                          $scope.plot_layout = selected_style.plot_layout
                             })


                        });

                        $scope.load_attribute = function($event){
                           function DialogController($scope, $mdDialog,$rootScope) {
                             $scope.select_style = function(id){
                               $rootScope.$emit('load_selected_style', id);
                             }

                             var styles_db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/bimo');
                             styles_db.get("scatter plot styles").then(function(doc){
                               oo = doc
                               styles = doc.styles
                               $scope.styles = JSON.parse(JSON.stringify(doc.styles))

                               for(var i=0;i<$scope.styles.length;i++){
                                 for(var j=0;j<group_levels.length;j++){
                                  index = getAllIndexes(group, group_levels[j])
                                  if($scope.styles[i].plot_data[j] !== undefined){
                                    $scope.styles[i].plot_data[j].x = index.map(k=>x[k])
                                    $scope.styles[i].plot_data[j].y = index.map(k=>y[k])
                                    $scope.styles[i].plot_data[j].text = index.map(k => label[k])
                                    $scope.styles[i].plot_data[j].name = group_levels[j]
                                    $scope.styles[i].plot_data[j].legendgroup = group_levels[j]
                                  }else{
                                    $scope.styles[i].plot_data[j] = JSON.parse(JSON.stringify(doc.default_style_plot_data))
                                    $scope.styles[i].plot_data[j].x = index.map(k=>x[k])
                                    $scope.styles[i].plot_data[j].y = index.map(k=>y[k])
                                    $scope.styles[i].plot_data[j].text = index.map(k => label[k])
                                    $scope.styles[i].plot_data[j].name = group_levels[j]
                                    $scope.styles[i].plot_data[j].legendgroup = group_levels[j]
                                  }

                                  }
                                 }


                               for(var i=0;i<$scope.styles.length;i++){
                                 for(var j=0;j<obj.ellipse.length;j++){

                                   if($scope.styles[i].plot_data_ellipse[j]!==undefined){
                                     $scope.styles[i].plot_data_ellipse[j].x = obj.ellipse[j].map(val => val[0])
                                     $scope.styles[i].plot_data_ellipse[j].y = obj.ellipse[j].map(val => val[1])
                                     $scope.styles[i].plot_data_ellipse[j].name = group_levels[j]
                                     $scope.styles[i].plot_data_ellipse[j].legendgroup = group_levels[j]
                                   }else{
                                     $scope.styles[i].plot_data_ellipse[j] = JSON.parse(JSON.stringify(doc.default_style_plot_data_ellipse))
                                     $scope.styles[i].plot_data_ellipse[j].x = obj.ellipse[j].map(val => val[0])
                                     $scope.styles[i].plot_data_ellipse[j].y = obj.ellipse[j].map(val => val[1])
                                     $scope.styles[i].plot_data_ellipse[j].name = group_levels[j]
                                     $scope.styles[i].plot_data_ellipse[j].legendgroup = group_levels[j]
                                   }


                                   if(!$scope.styles[i].plot_data_ellipse[j].show_ellipse){
                                      $scope.styles[i].plot_data_ellipse[j].line.width = 0
                                      $scope.styles[i].plot_data_ellipse[j].fill="none"
                                      $scope.styles[i].plot_data_ellipse[j].showlegend=false
                                      $scope.styles[i].plot_data_ellipse[j].opacity=0
                                    }




                                 }
                               }



                               // adjust the size of the plot to fit into 600width and 450height. And hide the legend.
                               $scope.desire_width = 400
                               $scope.desire_height = 300
                               $scope.actual_width = []
                               $scope.actual_height = []
                               for(var i=0; i<$scope.styles.length;i++){
                                 time = Math.min($scope.desire_width/$scope.styles[i].plot_layout.width, $scope.desire_height/$scope.styles[i].plot_layout.height)
                                 // layout
                                 $scope.styles[i].plot_layout.width = $scope.styles[i].plot_layout.width? $scope.styles[i].plot_layout.width*time:undefined
                                 $scope.styles[i].plot_layout.height = $scope.styles[i].plot_layout.height? $scope.styles[i].plot_layout.height*time:undefined

                                 $scope.actual_width.push($scope.styles[i].plot_layout.width)
                                 $scope.actual_height.push($scope.styles[i].plot_layout.height)

                                 $scope.styles[i].plot_layout.margin.l = $scope.styles[i].plot_layout.margin.l? $scope.styles[i].plot_layout.margin.l*time:undefined
                                 $scope.styles[i].plot_layout.margin.r = $scope.styles[i].plot_layout.margin.r? $scope.styles[i].plot_layout.margin.r*time:undefined
                                 $scope.styles[i].plot_layout.margin.t = $scope.styles[i].plot_layout.margin.t? $scope.styles[i].plot_layout.margin.t*time:undefined
                                 $scope.styles[i].plot_layout.margin.b = $scope.styles[i].plot_layout.margin.b? $scope.styles[i].plot_layout.margin.b*time:undefined
                                 $scope.styles[i].plot_layout.margin.pad = $scope.styles[i].plot_layout.margin.pad? $scope.styles[i].plot_layout.margin.pad*time:undefined
                                 $scope.styles[i].plot_layout.titlefont.size = $scope.styles[i].plot_layout.titlefont.size? $scope.styles[i].plot_layout.titlefont.size*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.titlefont.size = $scope.styles[i].plot_layout.xaxis.titlefont.size? $scope.styles[i].plot_layout.xaxis.titlefont.size*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.ticklen = $scope.styles[i].plot_layout.xaxis.ticklen? $scope.styles[i].plot_layout.xaxis.ticklen*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.tickwidth = $scope.styles[i].plot_layout.xaxis.tickwidth? $scope.styles[i].plot_layout.xaxis.tickwidth*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.tickfont.size = $scope.styles[i].plot_layout.xaxis.tickfont.size? $scope.styles[i].plot_layout.xaxis.tickfont.size*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.linewidth = $scope.styles[i].plot_layout.xaxis.linewidth? $scope.styles[i].plot_layout.xaxis.linewidth*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.gridwidth = $scope.styles[i].plot_layout.xaxis.gridwidth? $scope.styles[i].plot_layout.xaxis.gridwidth*time:undefined
                                 $scope.styles[i].plot_layout.xaxis.zerolinewidth = $scope.styles[i].plot_layout.xaxis.zerolinewidth? $scope.styles[i].plot_layout.xaxis.zerolinewidth*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.titlefont.size = $scope.styles[i].plot_layout.yaxis.titlefont.size? $scope.styles[i].plot_layout.yaxis.titlefont.size*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.ticklen = $scope.styles[i].plot_layout.yaxis.ticklen? $scope.styles[i].plot_layout.yaxis.ticklen*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.tickwidth = $scope.styles[i].plot_layout.yaxis.tickwidth? $scope.styles[i].plot_layout.yaxis.tickwidth*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.tickfont.size = $scope.styles[i].plot_layout.yaxis.tickfont.size? $scope.styles[i].plot_layout.yaxis.tickfont.size*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.linewidth = $scope.styles[i].plot_layout.yaxis.linewidth? $scope.styles[i].plot_layout.yaxis.linewidth*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.gridwidth = $scope.styles[i].plot_layout.yaxis.gridwidth? $scope.styles[i].plot_layout.yaxis.gridwidth*time:undefined
                                 $scope.styles[i].plot_layout.yaxis.zerolinewidth = $scope.styles[i].plot_layout.yaxis.zerolinewidth? $scope.styles[i].plot_layout.yaxis.zerolinewidth*time:undefined
                                 $scope.styles[i].plot_layout.legend.borderwidth = $scope.styles[i].plot_layout.legend.borderwidth? $scope.styles[i].plot_layout.legend.borderwidth*time:undefined
                                 $scope.styles[i].plot_layout.legend.font.size = $scope.styles[i].plot_layout.legend.font.size? $scope.styles[i].plot_layout.legend.font.size*time:undefined
                                 $scope.styles[i].plot_layout.legend.tracegroupgap = $scope.styles[i].plot_layout.legend.tracegroupgap? $scope.styles[i].plot_layout.legend.tracegroupgap*time:undefined
                                 $scope.styles[i].plot_layout.showlegend = false
                                 // plot_data_ellipse
                                 for(var j=0;j<obj.ellipse.length;j++){
                                   $scope.styles[i].plot_data_ellipse[j].line.width = $scope.styles[i].plot_data_ellipse[j].line.width? $scope.styles[i].plot_data_ellipse[j].line.width*time:0
                                 }
                                 // plot_data
                                 for(var j=0;j<group_levels.length;j++){
                                   $scope.styles[i].plot_data[j].textfont.size = $scope.styles[i].plot_data[j].textfont.size? $scope.styles[i].plot_data[j].textfont.size*time:undefined
                                   $scope.styles[i].plot_data[j].marker.size = $scope.styles[i].plot_data[j].marker.size? $scope.styles[i].plot_data[j].marker.size*time:undefined
                                   $scope.styles[i].plot_data[j].marker.line.width = $scope.styles[i].plot_data[j].marker.line.width? $scope.styles[i].plot_data[j].marker.line.width*time:undefined
                                 }
                               }

                               // adjust the axis range using plot_data and plot_data_ellipse
                               for(var i=0; i<$scope.styles.length;i++){
                                 ppp = $scope.styles[i].plot_data

                                 $scope.styles[i].plot_layout.xaxis.xaxis_range_min = xaxis_range_min
                                 $scope.styles[i].plot_layout.xaxis.xaxis_range_max = xaxis_range_max

                                 $scope.styles[i].plot_layout.yaxis.yaxis_range_min = yaxis_range_min
                                 $scope.styles[i].plot_layout.yaxis.yaxis_range_max = yaxis_range_max

                                 $scope.styles[i].plot_layout.xaxis.range = [xaxis_range_min, xaxis_range_max]
                                 $scope.styles[i].plot_layout.yaxis.range = [yaxis_range_min, yaxis_range_max]

                               }

                               var calculate_loop = setInterval(function(){
                                 if($("#"+$scope.styles[$scope.styles.length-1].plot_id).length>0){
                                   clearInterval(calculate_loop);
                                   for(var i=0;i<$scope.styles.length;i++){
                                     if(i == $scope.styles.length-1){
                                       eee = $scope.styles[i].plot_data_ellipse
                                     }
                                     Plotly.newPlot($scope.styles[i].plot_id,
                                     //$scope.styles[i].plot_data,
                                     $scope.styles[i].plot_data_ellipse.concat($scope.styles[i].plot_data),
                                     $scope.styles[i].plot_layout, {staticPlot: true})
                                   }
                                 }
                               },10)


                             })

                            }
                           var parentEl = angular.element(document.body);
                           $mdDialog.show({
                             parent: parentEl,
                             targetEvent: $event,
                             templateUrl:'/ocpu/library/Abib.alpha/www/views/bimo/scatter plot style.html',
                             locals: {
                               imagePath: $scope.imagePath
                             },
                             controller: DialogController,
                             clickOutsideToClose:true
                          });

                        }

                        $scope.publish_attribute = function($event){
                          function publish_attribute_controller($scope, $mdDialog,$rootScope) {
                            $scope.submit_publish_scatter_plot_style = function(){
                              new_style = $scope.style
                              new_style.plot_layout = JSON.parse(JSON.stringify(plot_layout))
                              new_style.plot_data_ellipse = JSON.parse(JSON.stringify(plot_data_ellipse))
                              new_style.plot_data = JSON.parse(JSON.stringify(plot_data))
                              for(var i=0;i<new_style.plot_data_ellipse.length;i++){
                                new_style.plot_data_ellipse[i].x = []
                                new_style.plot_data_ellipse[i].y = []
                                new_style.plot_data_ellipse[i].name = ""
                                new_style.plot_data_ellipse[i].legendgroup = ""
                              }
                              for(var i=0;i<new_style.plot_data.length;i++){
                                new_style.plot_data[i].x = []
                                new_style.plot_data[i].y = []
                                new_style.plot_data[i].text = []
                                new_style.plot_data[i].name = ""
                                new_style.plot_data[i].legendgroup = ""
                              }
                              var bimo = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/bimo');
                              bimo.get("scatter plot style candidates").then(function(doc){
                                doc.styles.push(new_style)
                                bimo.put(doc).then(function(){
                                  $mdDialog.hide();
                                  $mdDialog.show(
                                    $mdDialog.alert()
                                      .parent(angular.element(document.body))
                                      .clickOutsideToClose(true)
                                      .title('Success!')
                                      .textContent("The publishing request has been recieved! A team will be contacting you shortly.")
                                      .ariaLabel('Publishing Request Recieved')
                                      .ok('Got it!')
                                    );
                                })
                              })
                            }
                          }
                          $mdDialog.show({
                            parent:angular.element(document.body),
                            targetEvent:$event,
                            templateUrl:'/ocpu/library/Abib.alpha/www/views/bimo/publish_scatter_plot_style.html',
                            /*locals:{

                            },*/
                            controller:publish_attribute_controller,
                            clickOutsideToClose:true,
                            fullscreen: true,
                            flex:"66"
                          })
                        }

                        $scope.publish_attribute_admin = function($event){
                          function publish_attribute_controller($scope, $mdDialog,$rootScope) {
                            $scope.submit_publish_scatter_plot_style = function(){
                              new_style = $scope.style
                              new_style.plot_layout = JSON.parse(JSON.stringify(plot_layout))
                              new_style.plot_data_ellipse = JSON.parse(JSON.stringify(plot_data_ellipse))
                              new_style.plot_data = JSON.parse(JSON.stringify(plot_data))
                              var d = new Date();
                              var time_string = d.getTime().toString()
                              // generate a id with timestamp
                              new_style.plot_id = "plot_"+time_string

                              for(var i=0;i<new_style.plot_data_ellipse.length;i++){
                                new_style.plot_data_ellipse[i].x = []
                                new_style.plot_data_ellipse[i].y = []
                                new_style.plot_data_ellipse[i].name = ""
                                new_style.plot_data_ellipse[i].legendgroup = ""
                              }
                              for(var i=0;i<new_style.plot_data.length;i++){
                                new_style.plot_data[i].x = []
                                new_style.plot_data[i].y = []
                                new_style.plot_data[i].text = []
                                new_style.plot_data[i].name = ""
                                new_style.plot_data[i].legendgroup = ""
                              }
                              var bimo = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/bimo');
                              bimo.get("scatter plot styles").then(function(doc){
                                doc.styles.push(new_style)
                                bimo.put(doc).then(function(){
                                  $mdDialog.hide();
                                  $mdDialog.show(
                                    $mdDialog.alert()
                                      .parent(angular.element(document.body))
                                      .clickOutsideToClose(true)
                                      .title('Success!')
                                      .textContent("The publishing request has been recieved! A team will be contacting you shortly.")
                                      .ariaLabel('Publishing Request Recieved')
                                      .ok('Got it!')
                                    );
                                })
                              })
                            }
                          }
                          $mdDialog.show({
                            parent:angular.element(document.body),
                            targetEvent:$event,
                            templateUrl:'/ocpu/library/Abib.alpha/www/views/bimo/publish_scatter_plot_style - admin.html',
                            /*locals:{

                            },*/
                            controller:publish_attribute_controller,
                            clickOutsideToClose:true,
                            fullscreen: true,
                            flex:"66"
                          })
                        }


                      })
                    })
                  }).fail(function(){
                    $scope.$apply(function(){$scope.calculating = false})
                    alert("Error: " + req.responseText)
                  })
                }else{
                  console.log("waiting the ellipse data")
                }
              },10)



            }



          $scope.$watch("plot_data",function(newValue, oldValue){
            if(newValue!==oldValue){
              var data = $scope.plot_data_ellipse.concat($scope.plot_data);
              $scope.scatter_plot(data,$scope.plot_layout)
              // next two variables were for the saving plot.
              being_plotted_data = data
              being_plotted_layout = $scope.plot_layout
            }
          },true)
          $scope.$watch("plot_data_ellipse",function(newValue, oldValue){
            if(newValue!==oldValue){
              var data = $scope.plot_data_ellipse.concat($scope.plot_data);
              $scope.scatter_plot(data,$scope.plot_layout)
              // next two variables were for the saving plot.
              being_plotted_data = data
              being_plotted_layout = $scope.plot_layout
            }
          },true)
          $scope.$watch("plot_layout",function(newValue, oldValue){
            if(newValue!==oldValue){
              var data = $scope.plot_data_ellipse.concat($scope.plot_data);
              $scope.scatter_plot(data,$scope.plot_layout)
              // next two variables were for the saving plot.
              being_plotted_data = data
              being_plotted_layout = $scope.plot_layout
            }
          },true)

          $scope.scatter_plot = function(data,layout){
            // initialize the data
            Plotly.newPlot('plot', data, layout)
            .then(
                function(gd)
                 {
                   gg = gd
                  Plotly.toImage(gd,{format:'svg', height:plot_layout.height,width:plot_layout.width})
                     .then(
                        function(url)
                     {
                       plot_url = url
                     }
                     )
              });

          }

          $scope.confirm_save_plot = function($event){

            function Save_plot_DialogController($scope, $mdDialog,$rootScope) {

              $scope.show_download_link = false
              $scope.file_format_options = [
                {
                  value:"PNG",
                  text:"PNG (Portable Network Graphics)"
                },{
                  value:"SVG",
                  text:"SVG (Scalable Vector Graphics)"
                },{
                  value:"EMF",
                  text:"EMF (Enhanced Metafile) [PPT editable]"
                },{
                  value:"PDF",
                  text:"PDF (Portable Document Format)"
                }
              ]
              $scope.file_format = {
                value:"EMF"
              }

              $scope.save_plot = function(){
                $scope.show_download_link = false
                var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                  ddd = doc
                  var d = new Date();
                  var time_string = d.getTime().toString()

                  filename = "PubSciGrapher"

                  parent_id = "root"

                  var has_BIMO = false;
                  for(var i=0;i<doc.tree_structure.length;i++){
                    if(doc.tree_structure[i].text == $scope.file_name +"." +$scope.file_format.value.toLowerCase()){
                      alert('The file name: "' +$scope.file_name + $scope.file_format.value.toLowerCase()+ '" is taken.');return false;
                    }
                    if(doc.tree_structure[i].id == filename+"_68410298_"+doc._id.split("_68410298_")[1]){
                      has_BIMO = true;
                    }
                  }
                  console.log(has_BIMO)
                  if(!has_BIMO){
                    doc.tree_structure.push({
                      id:filename+"_68410298_"+doc._id.split("_68410298_")[1],
                      parent:parent_id,
                      text:"PubSciGrapher",
                      icon:"fa fa-folder",
                      source:{
                        FUNCTION:'bimo_scatter_plot',
                        PARAMETER:{
                          scatter_plot:true
                        }
                      },
                      source_node_id:data_being_used,
                      report:"bimo_scatter_plot"
                    })
                  }

                  if($scope.file_format.value == "PNG"){// !!! we can change the resolution here by larging the plot!!
                      Plotly.newPlot('saving_plot_div', being_plotted_data, being_plotted_layout)
                        .then(
                            function(gd)
                             {
                              Plotly.toImage(gd,{format:'png', height:being_plotted_layout.height,being_plotted_layout:plot_layout.width})
                                 .then(
                                    function(url)
                                 {
                                    var plot_url = url
                                    doc.tree_structure.push({
                                      id:$scope.file_name+"_68410298_"+time_string+"_png",
                                      parent:filename+"_68410298_"+doc._id.split("_68410298_")[1],
                                      text:$scope.file_name+".png",
                                      icon:"fa fa-file-picture-o",
                                      source:{
                                        FUNCTION:'bimo_scatter_plot',
                                        PARAMETER:{
                                          scatter_plot:true
                                        }
                                      },
                                      attname:$scope.file_name+"_68410298_"+time_string+".png",
                                      source_node_id:data_being_used,
                                      type:""
                                    })
                                    doc['_attachments'][$scope.file_name+"_68410298_"+time_string+".png"] = {
                                          content_type:"image/png",
                                          "data": plot_url.split("base64,")[1]
                                        }
                                    db.put(doc).then(function(){
                                       $mdToast.show($mdToast.simple().textContent('Plot saved!').position('bottom right').hideDelay(3000));
                                       $scope.$apply(function(){
                                         $scope.saving = false;
                                         $scope.show_save = false;
                                         $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                                       })
                                    })
                                 }
                                 )
                          });
                  }else if($scope.file_format.value == "SVG"){


                    Plotly.newPlot('saving_plot_div', being_plotted_data, being_plotted_layout)
                        .then(
                            function(gd)
                             {
                              Plotly.toImage(gd,{format:'svg', height:being_plotted_layout.height,being_plotted_layout:plot_layout.width})
                                 .then(
                                    function(url)
                                 {
                                   plot_url = url
                                   plot_url = plot_url.replace(/^data:image\/svg\+xml,/, '');
                                   plot_url = decodeURIComponent(plot_url);
                                   doc.tree_structure.push({
                                      id:$scope.file_name+"_68410298_"+time_string+"_svg",
                                      parent:filename+"_68410298_"+doc._id.split("_68410298_")[1],
                                      text:$scope.file_name+".svg",
                                      icon:"fa fa-file-picture-o",
                                      source:{
                                        FUNCTION:'bimo_scatter_plot',
                                        PARAMETER:{
                                          scatter_plot:true
                                        }
                                      },
                                      attname:$scope.file_name+"_68410298_"+time_string+".svg",
                                      source_node_id:data_being_used,
                                      type:""
                                    })

                                    doc['_attachments'][$scope.file_name+"_68410298_"+time_string+".svg"] = {
                                          content_type:"image/svg+xml",
                                          "data": btoa(unescape(encodeURIComponent(plot_url)))
                                        }
                                    db.put(doc).then(function(){
                                       $mdToast.show($mdToast.simple().textContent('Plot saved!').position('bottom right').hideDelay(3000));
                                       $scope.$apply(function(){
                                         $scope.saving = false;
                                         $scope.show_save = false;
                                         $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                                       })
                                    })
                                 })
                             })


                  }else{

                    $scope.$apply(function(){
                      $scope.disable_save_button = true
                    })

                    console.log($scope.disable_save_button)

                       Plotly.newPlot('saving_plot_div', being_plotted_data, being_plotted_layout)
                        .then(
                            function(gd)
                             {
                              Plotly.toImage(gd,{format:'svg', height:being_plotted_layout.height,being_plotted_layout:plot_layout.width})
                                 .then(
                                    function(url)
                                 {
                                   plot_url = url
                                   plot_url = plot_url.replace(/^data:image\/svg\+xml,/, '');
                                   plot_url = decodeURIComponent(plot_url);

                                   temp_url = $scope.file_name+"_68410298_"+time_string+"_68410298_TEMP.svg"

                                   doc['_attachments'][temp_url] = {
                                          content_type:"image/svg+xml",
                                          "data": btoa(unescape(encodeURIComponent(plot_url)))
                                        }
                                    db.put(doc).then(function(){
                                      var req = ocpu.call("transport_svg",{
                                          project_ID:localStorage.getItem("project_id_global"),
                                          file_name:$scope.file_name+"_68410298_"+time_string+"_68410298_TEMP.svg",
                                          format:$scope.file_format.value
                                      },function(session){

                                        console.log(session)
                                         $scope.$apply(function(){
                                            $scope.disable_save_button = false
                                            $scope.download_href= session.loc + "files/output."+$scope.file_format.value.toLowerCase()
                                            $scope.download_name = $scope.file_name+"."+$scope.file_format.value.toLowerCase()
                                            $scope.show_download_link = true
                                          })

                                        console.log($scope.disable_save_button)
                                      })
                                    })
                                 })
                             })


                  }





                })
              }


            }

            var parentEl = angular.element(document.body);
            $mdDialog.show({
             parent: parentEl,
             targetEvent: $event,
             templateUrl:'/ocpu/library/Abib.alpha/www/views/bimo/save scatter plot style.html',
             controller: Save_plot_DialogController,
             clickOutsideToClose:true
            });

            };




        })
      })


    })
    .controller("descriptive_statistics_controller", function($scope,$mdDialog, $rootScope, $http, $timeout, $mdToast, get_filename_service, get_parent_service){

      $scope.two_factor = false
      $scope.calculating = false
      $scope.table_ready = false
      $scope.method = "mean"
      $scope.table_ready = false
      $scope.table_options = {
        footerHeight: false,
        scrollbarV: true,
        headerHeight: 50,
        selectable: true,
        multiSelect: false,
        sortable:false,
        columnMode:"force",
        columns: [{
          name: "Name",
          prop: "name"
        }, {
          name: "Gender",
          prop: "gender"
        }, {
          name: "Company",
          prop: "company"
        }]
      };
      $http.get('js/100data.json').success(function(data) {
        $scope.table_data = data.splice(0, 10);
      });// for initializing the table.


      var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
        db.get(localStorage.getItem("project_id_global")).then(function(doc){
          ccc = doc;
          var expression_id_options = []
          var tree_structure = doc.tree_structure
          for(var i=0; i < tree_structure.length; i++){
            if(tree_structure[i].type == "data_set"){
              expression_id_options.push({
                "expression_id":tree_structure[i].id,
                "expression_text":tree_structure[i].text
              })
            }
          }
        $scope.$apply(function(){
          $scope.expression_id_options = expression_id_options
          $scope.expression_id = localStorage.getItem('activated_data_id')
          $scope.study_design = doc.study_design
          $scope.factor1_options = doc.sample_info_column_name
          $scope.factor2_options = doc.sample_info_column_name
          if(typeof(doc.study_design)=='string'){
            $scope.two_factor = false
            $scope.factor1=doc.study_design
          }else{
            $scope.two_factor = true
            $scope.factor1=doc.study_design[0]
            $scope.factor2=doc.study_design[1]
          }
          $scope.$watch("factor1",function(value){
            $scope.levels1_options = doc.sample_info[value]
            $scope.levels1 = doc.sample_info[value]
          })
          $scope.$watch("factor2",function(value){
            $scope.levels2_options = doc.sample_info[value]
            $scope.levels2 = doc.sample_info[value]
          })
        })
      })


      $scope.submit = function(FUNCTION){


          $scope.calculating = true;

          $scope.analysis_finished = false
          $scope.table_ready = false;

          /*Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/"+localStorage.getItem("activated_data_id").replace("_csv",".csv"), {header: true,download: true,complete: function(results) {e = results;e.data.pop();}});
          Papa.parse("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/"+localStorage.getItem("project_id_global")+"/sample_info_68410298_"+$scope.expression_id.split("_68410298_")[1].replace("_csv",".csv"), {header: true,download: true,complete: function(results) {p = results;
if(localStorage.getItem("activated_data_id").split("_68410298_")[1].indexOf(localStorage.getItem("project_id_global").split("_68410298_")[1])!==-1){
  p.data.pop();
}
}});*/
        var d = new Date();
          var time_string = d.getTime().toString()
          // change PARAMETER according to FUNCTION
          //var PARAMETER;
          switch (FUNCTION) {
              case "fold_change":
                  PARAMETER = {
                    project_ID:localStorage.getItem("project_id_global"),
                    expression_id:localStorage.getItem("activated_data_id"),
                    sample_info_id:"sample_info_68410298_" + localStorage.getItem("activated_data_id").split("_68410298_")[1],
                    group_name1:$scope.factor1,
                    levels1:$scope.levels1,
                    two_factor:$scope.two_factor,
                    group_name2:$scope.factor2,
                    levels2:$scope.levels2,
                    method:$scope.method
                  }
                  break;
              case 'others':
                  PARAMETER = {}
          }
            var db_task = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib_task');
            var newtask_id = localStorage.getItem("username") + "_68410298_" + time_string
            var new_task = {
              "_id":newtask_id,
              FUNCTION : FUNCTION,
              PARAMETER: PARAMETER,
              STATUS:"pending",PROJECT_ID:localStorage.getItem("project_id_global")
            }
            db_task.put(new_task).then(function(){
              console.log("Added:" + newtask_id)
               var req = ocpu.call("CALCULATE_wrapper",{
                task_id:newtask_id
              },function(session){
                $scope.show_save_result = true
                sss = session
                session.getObject(function(obj){
                  ooo = obj
                  var csv = Papa.unparse(obj.out.table_data);
                  var options = []
                    for(var i=0; i<Object.keys(obj.out.table_data[0]).length; i++){
                      options.push({
                              name: Object.keys(obj.out.table_data[0])[i],
                              prop: Object.keys(obj.out.table_data[0])[i]
                            })
                    }

                    $scope.$apply(function(){
                      $scope.table_options.columns = options
                      $scope.table_data = obj.out.table_data
                      $scope.refresh_table = function(){
                        $scope.table_data = obj.out.table_data;
                      }
                      $scope.table_ready = true
                      $scope.calculating = false;
                      $scope.show_save = true;
                      $scope.save_result = function(){
                        $scope.saving = true
                        var db = new PouchDB('http://slfan:metabolomics@chemrichdb2.fiehnlab.ucdavis.edu/db/abib');
                        db.get(localStorage.getItem("project_id_global"), {attachments: true}).then(function(doc){
                          dd = doc

                          filename = get_filename_service.get_filename(doc,$scope.$state.current.data.pageTitle,sibling_id=PARAMETER.expression_id)

                          var parent_id = get_parent_service.get_parent(doc, PARAMETER.expression_id)

                          doc.tree_structure.push({
                            id:filename+"_68410298_"+time_string,
                            parent:parent_id,
                            text:filename,
                            icon:"fa fa-folder",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            source_node_id:PARAMETER.expression_id,
                            report:obj.out.report_text[0]
                          })
                          doc.tree_structure.push({
                            id:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+"_csv",
                            parent:filename+"_68410298_"+time_string,
                            text:$scope.$state.current.data.pageTitle+".csv",
                            icon:"fa fa-file-excel-o",
                            source:{
                              FUNCTION:FUNCTION,
                              PARAMETER:PARAMETER
                            },
                            attname:$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv",
                            source_node_id:filename+"_68410298_"+time_string,
                            type:"sample_related_result"
                          })

                          doc['_attachments'][$scope.$state.current.data.pageTitle+"_68410298_"+time_string+".csv"] = {
                            content_type:"application/vnd.ms-excel",
                            "data": btoa(csv)
                          }

                          db.put(doc).then(function(){
                             $mdToast.show($mdToast.simple().textContent('Result saved!').position('bottom right').hideDelay(3000));
                             $scope.$apply(function(){
                               $scope.saving = false;
                               $scope.show_save_result = false;
                               $rootScope.$emit('update_tree', localStorage.getItem("project_id_global"));
                             })
                          })
                        })
                      }
                    })
                })

              }).fail(function(){
                $scope.$apply(function(){$scope.calculating = false})
                alert("Error: " + req.responseText)
              })
            })




      }


    })



































