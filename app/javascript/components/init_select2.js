import $ from 'jquery';
import 'select2';


const initSelect2 = () => {
  let div = document.querySelector(".select2")
  if(div.multiple == true) {
  $('.select2').select2({multiple: true, tags: true, width: "100%", placeholder: "Add here!"});
  }
  else {
    $('.select2').select2({width: "100%", placeholder: "Add here!"});
  }
};


export { initSelect2 };
