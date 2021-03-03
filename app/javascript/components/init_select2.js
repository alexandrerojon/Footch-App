import $ from 'jquery';
import 'select2';


const initSelect2 = () => {
  $('.select2').select2({multiple: true, tags: true, width: "100%", placeholder: "Add here!"});
};


export { initSelect2 };
