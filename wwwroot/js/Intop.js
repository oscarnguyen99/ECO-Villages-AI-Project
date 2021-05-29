const { reload } = require("browser-sync");
var counter = 0;


function createAlert() {
    alert("Hello there");

}

function SetElement(id) {
    document.getElementById(id).innerText = "hello";

}


function GenerateBars(datatodisplay, labelstodisplay)
{
    var chcontainer = document.getElementById("chCon");
    chcontainer.style = " z-index: 1;  visibility:visible; Height : 80%; Width: 80%;";
  


    var element = document.getElementById("ftxt");
    element.innerText = ""
    var dtd = datatodisplay;
   
    var sel = document.getElementById('graphtype');
    sel.style = " z-index: 1;  visibility:visible;";

    var ctx = document.getElementById('testchart');
    
    
  

    new Chart(ctx, {
        type: sel.value,
        data: {
            labels: labelstodisplay, datasetElementType: null,
            datasets: [{
                label: 'Temp',
                data: dtd,
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
                borderWidth: 1,
                pointStyle: "circle",
                
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
    //var getChart = document.getElementById("chart-container");
    //getChart.value = null;
    counter = counter + 1;

    if (counter >= 1)
    {
        alert("sup");
        var chcontainer = document.getElementById("chCon");
        chcontainer.style = " z-index: 1;  visibility:visible; Height : 80%; Width: 80%;";
        chcontainer.innerHTML = reload();
        chcontainer.innerText = "";

        var sel = document.getElementById('graphtype');
        sel.style = " z-index: 1;  visibility:visible;";
    }

   // console.log(counter);


    //getChart.type = "reset";
    //getChart.inputMode = "reset";
    //getChart.innerHTML = null;

    
    
}


function LogList(PolutionList)
{
    console.clear();
    console.log(PolutionList);
    console.log(PolutionList.data[0].co);
    console.log(PolutionList.country_code);
}



function DisplayCurrentData(PolutionList)
{
    var tagH = document.createElement("p");
    var text = document.createTextNode("City Name:" + PolutionList.city_name);
    tagH.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tagH);

    var tag = document.createElement("p");
    var text = document.createTextNode("timezone:" + PolutionList.data[0].timezone);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("CO:" + PolutionList.data[0].co);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("o3:" + PolutionList.data[0].o3);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("predominant_pollen_type:" + PolutionList.data[0].predominant_pollen_type);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("so2:" + PolutionList.data[0].so2);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("pollen_level_tree:" + PolutionList.data[0].pollen_level_tree);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("pollen_level_weed:" + PolutionList.data[0].pollen_level_weed);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("no2:" + PolutionList.data[0].no2);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("pm25:" + PolutionList.data[0].pm25);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var tag = document.createElement("p");
    var text = document.createTextNode("pollen_level_grass:" + PolutionList.data[0].pollen_level_grass);
    tag.appendChild(text);
    var element = document.getElementById("ftxt");
    element.appendChild(tag);

    var element = document.getElementById("bd");
    element.style = " overflow:visible; align-items:center; max - height: 80 %; max - width: 80 %;";

    var sel = document.getElementById('graphtype');
    sel.style = " z-index: -1;  visibility:hidden;";
    var chcontainer = document.getElementById("chCon");
    chcontainer.style = " z-index: -1;  visibility:hidden; Height : 0%; Width: 0%;";


    LogList(PolutionList);


}




function ErrorMessageDB_Connection()
{
    alert("Error no Database Connection");

}