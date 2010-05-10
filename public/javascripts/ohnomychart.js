var chart;
var colors = {positive: "#3fb021", negative: "#b61515"};

$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: "graph",
      defaultSeriesType: "line",
      margin: [20, 50, 50, 80],
      plotBackgroundColor: "#ffffff",
      zoomType: "x"
    },
    
    plotOptions: {
      line: {
        color: colors[account.direction],
        marker: {
          enabled: false
        },
        lineWidth: 3
      },
    },
    
    title: {
      text: ""
    },
    
    subtitle: {
      text: "Click and drag to zoom in",
      style: {
        color: "#366",
        fontSize: "10pt",
        marginTop: "27px",
        marginLeft: "100px",
        textAlign: "left"
      }
    },
    
    tooltip: {
      formatter: function() {
        var date = "<strong>" + Highcharts.dateFormat("%B %e, %Y", this.x) + "</strong>";
        
        var prefix = (this.y < 0 ? "-" : "") + "$";
        var money = prefix + Highcharts.numberFormat(Math.abs(this.y) / 100, 2, '.', ',');
        
        return date + "<br/>" + money;
      }
    },
    
    toolbar: {
      itemStyle: {
        marginTop: "48px",
        marginLeft: "100px",
        padding: "1px 7px",
        fontSize: "10pt",
        border: "1px solid #4572A7"
      }
    },
    
    xAxis: {
      type: "datetime",
      dateTimeLabelFormats: {
        day: "%b %e",
        week: "%b %e",
        month: "%b '%y",
        year: "%Y"
      },
      labels: {
        style: {
          fontSize: "12pt",
          color: "#444"
        },
        y: 25
      }
    },
    
    yAxis: {
      title: {
        text: "",
      },
      labels: {
        style: {
          color: "#444"
        },
        formatter: function() {
          var prefix = (this.value < 0 ? "-" : "") + "$";
          return prefix + Highcharts.numberFormat(Math.abs(this.value) / 100, 0, '.', ',');
        }
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