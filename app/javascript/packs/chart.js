// app/javascript/packs/chart.js
/*global diaryData */
import Chart from 'chart.js/auto';
// [0.5]
console.log(diaryData)
// var jsonData = JSON.parse('<%= raw @jsonData.html_safe %>');
// var jsonData = [
//   { posi: 0.5, date: '2023-06-18' },
//   { nega: -1, date: '2023-06-18' },
//   { posi: 0.6, date: '2023-06-19' },
//   { nega: -0.3, date: '2023-06-19' }
// ];

document.addEventListener('DOMContentLoaded', function() {
  var positiveData = [];
  var negativeData = [];
  var dates = [];


  // データの集計
  for (var i = 0; i < diaryData.length; i++) {
    var data = diaryData[i];
    var date = data.date;
    var positive = data.posi || 0;
    var negative = data.nega || 0;

    dates.push(date);
    positiveData.push(+positive);
    negativeData.push(+negative);
  }

  var chartContainer = document.getElementById('myChart');
  var ctx = chartContainer.getContext('2d');

  new Chart(ctx, {
    type: 'line',
    data: {
      labels: dates,
      datasets: [
        {
          label: 'ポジティブ',
          data: positiveData,
          borderColor: '#ffb6c1',
          backgroundColor: '#db7093',
          fill: true,
        },
        {
          label: 'ネガティブ',
          data: negativeData,
          borderColor: '#87ceeb',
          backgroundColor: '#add8e6',
          fill: true,
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          display: true,
          title: {
            display: true,
            text: '日付'
          }
        },
        y: {
          display: true,
          title: {
            display: true,
            text: '感情スコア'
          },
          suggestedMin: -1,
          suggestedMax: 1,
          ticks: {
            stepSize: 0.1
          }
        }
      },
      animation: {
        duration: 2000,
        easing: 'easeInOutQuart'
      },
      plugins: {
        legend: {
          display: true,
          position: 'top'
        },
        title: {
          display: true,
          text: '感情スコアの推移'
        }
      }
    }
  });
});