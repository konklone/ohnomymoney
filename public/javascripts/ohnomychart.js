var chart;

$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: "main-chart",
      defaultSeriesType: 'line'
    },
    title: {
      text: account.name
    }
  });
});