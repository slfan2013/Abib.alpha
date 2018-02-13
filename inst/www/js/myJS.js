function getAllIndexes(arr, val) {
    var indexes = [], i;
    for(i = 0; i < arr.length; i++)
        if (arr[i] === val)
            indexes.push(i);
    return indexes;
} // get all the indexes of value in an array

function unique(value, index, self) {
    return self.indexOf(value) === index;
} // [].filter(unique)

function unpack(rows, key) {
    return rows.map(function(row)
    { return row[key]; });
}// unpack(data,key)

function hexToRgb(hex,alpha) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? 'rgba('+parseInt(result[1], 16)+","+parseInt(result[2], 16)+","+parseInt(result[3], 16)+','+alpha+')' : null;
}// from RGB color to hex code
