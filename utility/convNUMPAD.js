// this function adds 0s to numbers, so you can specify the number of digits
// you want to show
// if you want to display three digits, then 3 would turn into 003 and 12 into 012

function lpad(value, padding) {
    var zeroes = new Array(padding+1).join("0");
    return (zeroes + value).slice(-padding);
}
