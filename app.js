function buildMetadata(sample) {

  // @TODO: Complete the following function that builds the metadata panel

  // Use `d3.json` to fetch the metadata for a sample

    // Use d3 to select the panel with id of `#sample-metadata`
    
    d3.json(`/metadata/${sample}`).then((data) => { 
      var panel = d3.select('#sample-metadata');
     

// Use `.html("") to clear any existing metadata
panel.html("")

Object.entries(data).forEach(([key,value]) => {
  panel.append('h6').text(key+':'+value)

})

    // Use `Object.entries` to add each key and value pair to the panel
    
    // Hint: Inside the loop, you will need to use d3 to append new
    // tags for each key-value in the metadata.
    });
    // BONUS: Build the Gauge Chart
    // buildGauge(data.WFREQ);
}

function buildCharts(sample) {
  
  // @TODO: Use `d3.json` to fetch the sample data for the plots
  d3.json(`/samples/${sample}`).then((data) => { 
    // @TODO: Build a Bubble Chart using the sample data
var otu_ids = data.otu_ids;
var otu_labels = data.otu_labels;
var sample_values = data.sample_values;

var trace1 = {
  x: otu_ids,
  y: sample_values,
  text: otu_labels,
  mode: 'markers',
  marker: {
    size: sample_values,
    color: otu_ids,
    colorscale: "Earth"
  }
};

var data = [trace1];

var layout = {
  title: 'Otu IDs',
  // showlegend: false,
  // height: 600,
  // width: 600
};

Plotly.newPlot('bubble', data, layout);
    // @TODO: Build a Pie Chart

    var data2 = [{
      values: sample_values.slice(0,10),
      labels: otu_ids.slice(0,10),
      hovertext: otu_ids.slice(0,10),
      hoverinfo: "hovertext",
      type: 'pie'
    }];
    
    var layout = {
      // height: 400,
      // width: 500
    };
    
    Plotly.newPlot('pie', data2, layout);    
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).
  })
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
