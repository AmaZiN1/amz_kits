function createKitBox(imgName, kitTitle, kitNameDB, reedemKitLocale){
  let kitbox = document.createElement("div");
  kitbox.classList.add("kit-box");

  let imagebox = document.createElement("div");
  imagebox.classList.add("image-box");
  let img = document.createElement("img");
  img.src = `icons/${imgName}`
  img.classList.add("image-style");
  imagebox.appendChild(img);

  let kitname = document.createElement("div");
  kitname.classList.add("kit-name");
  let kitnameText = document.createElement("span");
  kitnameText.textContent = kitTitle
  kitname.appendChild(kitnameText);

  let buttonbox = document.createElement("div");
  buttonbox.classList.add("button-box");
  let button = document.createElement("button");
  button.classList.add("reedem-button");
  button.setAttribute("id", kitNameDB);
  button.setAttribute("onclick", `reedemKit("${kitNameDB}")`);
  button.textContent = reedemKitLocale;
  buttonbox.appendChild(button);

  kitbox.appendChild(imagebox);
  kitbox.appendChild(kitname);
  kitbox.appendChild(buttonbox);

  return kitbox;
}

function createEmptyKitBox(emptyLocale){
  let emptykitbox = document.createElement("div")
  emptykitbox.classList.add("kit-box");
  emptykitbox.classList.add("empty");

  let span = document.createElement("span")
  span.classList.add("empty-span");
  span.textContent = emptyLocale

  emptykitbox.appendChild(span)

  return emptykitbox;
}

function reedemKit(kitNameDB){
  console.log(kitNameDB);
  $.post('http://amz_kits/reedemKit', JSON.stringify({
    kitNameDB: kitNameDB
    })
  );
}

$(document).ready(function(){
  window.addEventListener("message", (event) => {
    var data = event.data;
    if(data !== undefined && data.type === "enableui"){
      if(data.enable === true){
        document.getElementById("serverNameSpan").textContent = data.serverName;
        for(let i = 0;i < data.kits.length;i++){
          let box = createKitBox(data.kits[i].icon,data.kits[i].title,data.kits[i].name,data.locales.reedemKitLocale)
          document.getElementById("kits").appendChild(box);
        }
        for(let i = 0;i < (3 - data.kits.length);i++){
          let box = createEmptyKitBox(data.locales.emptyLocale)
          document.getElementById("kits").appendChild(box);
        }
        $('#main').show();
      }else {
        $('#main').hide();
      }
    }
  })
});

$("#close-button").click(()=>{
  document.getElementById("kits").innerHTML = "";
  $.post('http://amz_kits/closeNUI', JSON.stringify({
      enable: false
    })
  );
})