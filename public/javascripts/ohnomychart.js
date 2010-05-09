var chart;
var colors = {assets: "#3fb021", debts: "#b61515"};

$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: "main-chart",
      defaultSeriesType: 'line',
      margin: [20, 50, 25, 80],
      plotBackgroundColor: "#ffffff",
    },
    
    title: {
      text: ""
    },
    
    xAxis: {
      type: "datetime"
    },
    
    yAxis: {
      title: {
        text: "",
      }
    },
    
    series: [{
      name: account.name,
      data: account.balances
    }],
    
    legend: {
      enabled: false
    }
    
  });
});