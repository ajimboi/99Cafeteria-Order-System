var ctx = document.getElementById("chartjs_bar").getContext('2d');
var myChart = new Chart(ctx,
	{
		type: 'bar',
		data: {
			labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
			datasets: [
				{
					label: 'Total Sales(RM)',
					backgroundColor: '#8ee4af',
					borderColor: 'rgba(60,141,188,0.8)',
					pointRadius: false,
					pointColor: '#072c51',
					pointStrokeColor: 'rgba(60,141,188,1)',
					pointHighlightFill: '#fff',
					pointHighlightStroke: 'rgba(60,141,188,1)',
					barThickness: 100,
					data: [10],
				}
			]
		},
		options: {
			legend: {
				display: true,
				position: 'bottom',

				labels: {
					fontColor: '#8ee4af',
					fontFamily: 'Circular Std Book',
					fontSize: 14,
				}
			},
		}
	});