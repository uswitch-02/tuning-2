// app/javascript/packs/chart.js
/*global diaryData */
import Chart from 'chart.js/auto';

document.addEventListener('turbolinks:load',function() {
  var chartContainer = document.getElementById('myChart');
  var ctx = chartContainer.getContext('2d');

  new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['データセット1'],
      datasets: [{
        label: 'データセット1',
        data: diaryData,
        borderColor: 'red',
        backgroundColor: 'transparent'
      }]
    },
    options: {
      responsive: true,  // レスポンシブ対応（自動的にサイズ調整）
      maintainAspectRatio: false,  // アスペクト比の維持しない

      scales: {
        x: {
          display: true,  // X軸の表示
          title: {
            display: true,
            text: '日付'  // X軸のタイトル
          }
        },
        y: {
          display: true,  // Y軸の表示
          title: {
            display: true,
            text: '感情スコア'  // Y軸のタイトル
          },
          suggestedMin: 0,  // Y軸の最小値
          suggestedMax: 10,  // Y軸の最大値
          ticks: {
            stepSize: 5  // Y軸の目盛りの間隔
          }
        }
      },

      animation: {
        duration: 2000,  // アニメーションの時間（ミリ秒）
        easing: 'easeInOutQuart'  // アニメーションのイージング
      },

      plugins: {
        legend: {
          display: true,  // 凡例の表示
          position: 'top'  // 凡例の位置（top, bottom, left, right）
        },
        title: {
          display: true,
          text: '感情スコアの推移'  // グラフのタイトル
        }
      }
    }
  });
});