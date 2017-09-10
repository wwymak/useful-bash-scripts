const PNG = require('pngjs').PNG;
const fs = require('fs');

const data = require('./tmp.json');
const name = process.argv[2];
const uArr = data.u;
const vArr = data.v;

let u = {};
let v = {};

uArr.forEach(d => {
    u[d.key] = d.value
});
vArr.forEach(d => {
    v[d.key] = d.value
});

const width = u.Ni;
const height = u.Nj - 1;

const png = new PNG({
    colorType: 2,
    filterType: 4,
    width: width,
    height: height
});

for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
        let i = (y * width + x) * 4; //png pixels already done 4 entries per pixel since one per color channel
        let k = y * width + x;
        // let k = y * width + (x + width / 2) % width;
        png.data[i + 0] = Math.floor(255 * (u.values[k] - u.minimum) / (u.maximum - u.minimum));
        png.data[i + 1] = Math.floor(255 * (v.values[k] - v.minimum) / (v.maximum - v.minimum));
        png.data[i + 2] = 0; //blue channel
        png.data[i + 3] = 255;//opacity
    }
}

png.pack().pipe(fs.createWriteStream(name + '.png'));

fs.writeFileSync(name + '.json', JSON.stringify({
    source: 'http://nomads.ncep.noaa.gov',
    date: formatDate(u.dataDate + '', u.dataTime),
    width: width,
    height: height,
    uMin: u.minimum,
    uMax: u.maximum,
    vMin: v.minimum,
    vMax: v.maximum
}, null, 2) + '\n');

function formatDate(date, time) {
    return date.substr(0, 4) + '-' + date.substr(4, 2) + '-' + date.substr(6, 2) + 'T' +
        (time < 10 ? '0' + time : time) + ':00Z';
}
