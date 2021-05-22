function createAlert() {
    alert("Hello there");

}

function SetElement(id) {
    document.getElementById(id).innerText = "hello";

}


function GenerateBars(datatodisplay, labelstodisplay)
{
   
    var sel = document.getElementById('graphtype');
    

    var ctx = document.getElementById('testchart');
    new Chart(ctx, {
        type: sel.value,
        data: {
            labels: labelstodisplay, datasetElementType: null,
            datasets: [{
                label: 'Temp',
                data: datatodisplay,
                backgroundColor:[ 'rgba(255,99,132,0.2)', 'rgba(255,99,123,1)',
                'rgba(54,162,235,1)',
                'rgba(255,206,86,1)',
                'rgba(75,192,192,1)',
                    'rgba(153,102,255,1)', 'rgba(0, 140, 255, 1)', 'rgba(0, 0, 255, 0.59)', 'rgba(255, 168, 106, 1)', 'rgba(255, 249, 106, 1)','rgba(20, 147, 0, 1)'],
                borderColor: ['rgba(255,99,123,1)',
                    'rgba(54,162,235,1)',
                    'rgba(255,206,86,1)',
                    'rgba(75,192,192,1)',
                    'rgba(153,102,255,1)',
                    'rgba(255,159,64,1)'],
                borderWidth: 1
            }]

        },
        options:
        {
            responsive: true,
            scales:
            {
                yAxes:
                    [{
                        ticks:
                        {
                            beginAtZero: true
                        }   
                }]
                
            }
        }
    })
    
  
}


function setChartNull() {
    var getChart = document.getElementById("chart-container");
    getChart.value = null;
    alert("sup");
    //getChart.type = "reset";
    //getChart.inputMode = "reset";
    //getChart.innerHTML = null;

    
    
}


function LogList(PolutionList)
{
    console.log(PolutionList);

}