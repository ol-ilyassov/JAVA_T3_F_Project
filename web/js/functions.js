function reveal(id) {
    var x = document.getElementById("allshow "+ id);
    if (x.style.display === "none") {
        x.style.display = "table-cell";
    } else {
        x.style.display = "none";
    }
}

function updrecolor(id) {
    document.getElementById("td_update "+ id).style.backgroundColor="mediumpurple"
}

function upddecolor(id) {
    document.getElementById("td_update "+ id).style.backgroundColor="white"
}

function delrecolor(id) {
    document.getElementById("td_delete "+ id).style.backgroundColor="mediumpurple"
}

function deldecolor(id) {
    document.getElementById("td_delete "+ id).style.backgroundColor="white"
}

function descrecolor(id) {
    document.getElementById("td_description "+ id).style.backgroundColor="mediumpurple"
}

function descdecolor(id) {
    document.getElementById("td_description "+ id).style.backgroundColor="white"
}