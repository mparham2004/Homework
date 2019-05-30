// from data.js
var tableData = data;

// YOUR CODE HERE!
var tbody = d3.select('tbody');
function tableBuild(data){
tbody.html("")
data.forEach((element) => {
var row = tbody.append('tr')
Object.values(element).forEach((value) => {
var cell = row.append('td')
cell.text(value)

});


});


}

tableBuild(tableData);

function filter(){
d3.event.preventDefault()
var date = d3.select('#datetime').property('value')
var filterData = tableData
filterData = filterData.filter(row => row.datetime == date)
tableBuild(filterData)

};

d3.select('#filter-btn').on('click', filter);

