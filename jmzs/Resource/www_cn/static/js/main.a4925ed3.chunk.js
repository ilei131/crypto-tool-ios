(this.webpackJsonpsteg=this.webpackJsonpsteg||[]).push([[0],{111:function(e,t){},113:function(e,t){},142:function(e,t,a){"use strict";a.r(t);var n=a(0),s=a.n(n),r=a(67),c=a.n(r),l=a(21),i=a(22),m=a(24),o=a(23),u=(a(73),a(74),a(75),a(76),a(77),a(78),a(79),a(80),a(3)),p=a.n(u);a(143);var d=a(33),f=a.n(d),v=function(e){Object(m.a)(a,e);var t=Object(o.a)(a);function a(e){var n;return Object(l.a)(this,a),(n=t.call(this,e)).hidemsg=function(e){var t=n.state,a=t.esecret,s=t.epass,r=t.emsg,c=t.hmac,l=t.encrypt;if(""==s&&l)document.getElementById("password").setCustomValidity("\u8bf7\u6dfb\u52a0\u5bc6\u7801");else if(!r.includes(" ")||r.includes(" ")&&0==r.split(" ")[1].length)document.getElementById("message").setCustomValidity("\u5c01\u9762\u4fe1\u606f\u5e94\u81f3\u5c11\u5305\u542b2\u4e2a\u5355\u8bcd\uff01");else if(e.preventDefault(),"\u9690\u85cf"==n.state.btn){var i={};i.message=a,i.key=s,r.includes(" ")||(r+=" "),i.cover=r,n.setState({progress:!0});var m=new f.a(l,c).hide(i.message,i.key,i.cover);n.setState({rmsg:m,btn:"\u6e05\u9664",progress:!1})}else n.setState({btn:"\u9690\u85cf",rmsg:"",emsg:""})},n.demsg=function(e){e.preventDefault();var t=(new f.a).reveal(n.state.dmsg,n.state.dpass);n.setState({dsecret:t})},n.copyClip=function(e){e.preventDefault();var t=document.getElementById("res");t.select(),t.setSelectionRange(0,99999),document.execCommand("copy")},n.docs=function(e){return document.querySelector(e)},n.retRes=function(){return s.a.createElement("div",{style:{width:"inherit"}},s.a.createElement("div",{className:"flex-sb label-input100"},s.a.createElement("label",{className:"",htmlFor:"res"},"\u52a0\u5bc6\u540e\u7684\u4fe1\u606f*"),s.a.createElement("button",{style:{width:"20px",height:"25px"},onMouseEnter:function(){return n.docs(".copy").style.opacity=1},onMouseLeave:function(){return n.docs(".copy").style.opacity=0},id:"clip",className:"m-l-10 ",onClick:function(e){return n.copyClip(e)}},s.a.createElement("svg",{"aria-hidden":"true","data-prefix":"far","data-icon":"copy",role:"img",xmlns:"http://www.w3.org/2000/svg",viewBox:"0 0 448 512"},s.a.createElement("path",{d:"M433.941 65.941l-51.882-51.882A48 48 0 0 0 348.118 0H176c-26.51 0-48 21.49-48 48v48H48c-26.51 0-48 21.49-48 48v320c0 26.51 21.49 48 48 48h224c26.51 0 48-21.49 48-48v-48h80c26.51 0 48-21.49 48-48V99.882a48 48 0 0 0-14.059-33.941zM266 464H54a6 6 0 0 1-6-6V150a6 6 0 0 1 6-6h74v224c0 26.51 21.49 48 48 48h96v42a6 6 0 0 1-6 6zm128-96H182a6 6 0 0 1-6-6V54a6 6 0 0 1 6-6h106v88c0 13.255 10.745 24 24 24h88v202a6 6 0 0 1-6 6zm6-256h-64V48h9.632c1.591 0 3.117.632 4.243 1.757l48.368 48.368a6 6 0 0 1 1.757 4.243V112z"}))),s.a.createElement("div",{className:"copy"},s.a.createElement("span",null,"\u590d\u5236\u5230\u526a\u8d34\u677f"))),s.a.createElement("div",{style:{marginBottom:"15px"},className:"wrap-input100 "},s.a.createElement("textarea",{id:"res",className:"input100",name:"message",value:n.state.rmsg,readOnly:!0}),s.a.createElement("span",{className:"focus-input100"})),s.a.createElement("p",{className:"d-input100"},"\u590d\u5236\u5e76\u7c98\u8d34\u5230\u4efb\u4f55\u4f4d\u7f6e....."))},n.retBtn=function(){return s.a.createElement("div",{className:"container-contact100-form-btn m-b-25"},s.a.createElement("button",{className:"contact100-form-btn validate-form",onClick:function(e){return n.hidemsg(e)}},s.a.createElement("span",null,n.state.btn,s.a.createElement("i",{className:"zmdi zmdi-arrow-right m-l-8"}))))},n.state={esecret:"\u6211\u7684\u79d8\u5bc6",epass:"",encrypt:!0,hmac:!1,emsg:"\u4f60\u597d \u8fd9\u662f\u4e00\u6761\u673a\u5bc6\u4fe1\u606f",rmsg:"",dpass:"",dmsg:"",dsecret:"\u79d8\u5bc6",msgbox:"MESSAGE *",btn:"\u9690\u85cf",progress:!1,err:""},n}return Object(i.a)(a,[{key:"componentDidMount",value:function(){!function(){document.getElementById("adv1").addEventListener("click",(function(){document.getElementById("option").classList.toggle("trans")})),p()(".validate-input .input100").each((function(){p()(this).on("blur",(function(){0==t(this)?a(this):p()(this).parent().addClass("true-validate")}))}));var e=p()(".validate-input .input100");function t(e){if("email"==p()(e).attr("type")||"email"==p()(e).attr("name")){if(null==p()(e).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/))return!1}else if(""==p()(e).val().trim())return!1}function a(e){var t=p()(e).parent();p()(t).addClass("alert-validate"),p()(t).append('<span class="btn-hide-validate">&#xf136;</span>'),p()(".btn-hide-validate").each((function(){p()(this).on("click",(function(){n(this)}))}))}function n(e){var t=p()(e).parent();p()(t).removeClass("alert-validate"),p()(t).find(".btn-hide-validate").remove()}p()(".validate-form").on("submit",(function(){for(var n=!0,s=0;s<e.length;s++)0==t(e[s])&&(a(e[s]),n=!1);return n})),p()(".validate-form .input100").each((function(){p()(this).focus((function(){n(this),p()(this).parent().removeClass("true-validate")}))}))}()}},{key:"render",value:function(){var e=this;return s.a.createElement("div",{className:"container-contact100"},s.a.createElement("div",{style:{position:"relative"},className:"wrap-contact100"},s.a.createElement("form",{className:"contact100-form validate-form"},s.a.createElement("p",{className:" p-input100 text-center m-t-35"}," \u9690\u85cf\u79d8\u5bc6 "),s.a.createElement("hr",{className:"hr-input100 m-t-2"}),s.a.createElement("div",{className:"rs1 next"},s.a.createElement("label",{className:"fs-18 text-center p-b-11",htmlFor:"first-name"},"\u79d8\u5bc6"," "),s.a.createElement("div",{className:"wrap-input100 validate-input"},s.a.createElement("input",{id:"first-name",className:"input100 text-center",type:"text",name:"first-name",placeholder:"\u6211\u7684\u79d8\u5bc6",onChange:function(t){return e.setState({esecret:t.target.value})}}),s.a.createElement("span",{className:"focus-input100"}))),s.a.createElement("div",{className:"rs1 next"},s.a.createElement("label",{className:"fs-18 text-center p-b-11",htmlFor:"password"},"\u5bc6\u7801"),s.a.createElement("div",{className:"wrap-input100  validate-input"},s.a.createElement("input",{id:"password",className:"input100 text-center",type:"password",required:"required",disabled:!this.state.encrypt,name:"password",placeholder:"\u5bc6\u7801",onChange:function(t){return e.setState({epass:t.target.value})}}),s.a.createElement("span",{className:"focus-input100"}))),s.a.createElement("div",{style:{cursor:"pointer",textAlign:"left"},id:"adv1"}),s.a.createElement("label",{className:" label-input100 m-t-10 ",htmlFor:"message"},"\u5c55\u793a\u4fe1\u606f"),s.a.createElement("div",{className:"wrap-input100 validate-input"},s.a.createElement("textarea",{id:"message",className:"input100",name:"message",placeholder:"\u4f60\u597d \u8fd9\u662f\u4e00\u6761\u673a\u5bc6\u4fe1\u606f",onChange:function(t){return e.setState({emsg:t.target.value})},value:this.state.emsg}),s.a.createElement("span",{className:"focus-input100"})),this.retBtn(),"\u6e05\u9664"===this.state.btn?this.retRes():null,s.a.createElement("p",{className:" p-input100 text-center m-t-35"},"\u663e\u793a\u79d8\u5bc6 "),s.a.createElement("hr",{className:"hr-input100 m-t-2"}),s.a.createElement("div",{className:"label-input100 flex-sa"}),s.a.createElement("label",{className:"label-input100 m-l-2",htmlFor:"pass"},"\u5bc6\u7801"),s.a.createElement("div",{className:"wrap-input100 "},s.a.createElement("input",{id:"pass",className:"input100",type:"text",name:"first-name",placeholder:"\u5bc6\u7801",onChange:function(t){return e.setState({dpass:t.target.value})}}),s.a.createElement("span",{className:"focus-input100"})),s.a.createElement("label",{className:" label-input100 m-l-2",htmlFor:"mess"},"\u52a0\u5bc6\u540e\u7684\u4fe1\u606f *"),s.a.createElement("div",{className:"wrap-input100 "},s.a.createElement("textarea",{id:"mess",className:"input100",name:"mess",placeholder:"\u8bf7\u8f93\u5165\u52a0\u5bc6\u540e\u7684\u4fe1\u606f",onChange:function(t){return e.setState({dmsg:t.target.value})}}),s.a.createElement("span",{className:"focus-input100"})),s.a.createElement("div",{className:"container-contact100-form-btn"},s.a.createElement("button",{className:"contact100-form-btn",onClick:function(t){return e.demsg(t)}},s.a.createElement("span",null,"\u83b7\u53d6\u79d8\u5bc6",s.a.createElement("i",{className:"zmdi zmdi-arrow-right m-l-8"})))),s.a.createElement("label",{className:" label-input100 m-l-2 m-t-10"},"\u4f60\u7684\u79d8\u5bc6"),s.a.createElement("p",{className:" p-input100 text-center m-t-10 wraptext"},s.a.createElement("i",null," ",this.state.dsecret," ")))))}}]),a}(n.Component);Boolean("localhost"===window.location.hostname||"[::1]"===window.location.hostname||window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));c.a.render(s.a.createElement(s.a.StrictMode,null,s.a.createElement(v,null)),document.getElementById("root")),"serviceWorker"in navigator&&navigator.serviceWorker.ready.then((function(e){e.unregister()})).catch((function(e){console.error(e.message)}))},68:function(e,t,a){e.exports=a(142)},73:function(e,t,a){},74:function(e,t,a){},75:function(e,t,a){},76:function(e,t,a){},77:function(e,t,a){},78:function(e,t,a){},79:function(e,t,a){},80:function(e,t,a){},90:function(e,t){},92:function(e,t){}},[[68,1,2]]]);
//# sourceMappingURL=main.a4925ed3.chunk.js.map