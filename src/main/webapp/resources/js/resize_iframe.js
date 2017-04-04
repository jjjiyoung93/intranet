//document.domain = "sayclub.com";
document.domain = document.location.hostname.slice(document.location.hostname.lastIndexOf('.', document.location.hostname.lastIndexOf('.')-1) + 1); // sayclub.com, paran.com ����

function resize_frame(target,min_width,min_height)
{
  var o_body = document.frames(target).document.body;
  var o_frame = document.all(target);
  var t_height = o_body.scrollHeight + (o_body.offsetHeight - o_body.clientHeight);
  var t_width = o_body.scrollWidth + (o_body.offsetWidth - o_body.clientWidth);

  if(t_height < min_height)
    t_height = min_height;
  
  if(t_width < min_width)
    t_width = min_width;

  o_frame.style.height = t_height;
  o_frame.style.width = t_width;
}

