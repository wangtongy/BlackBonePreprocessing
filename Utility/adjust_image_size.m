
function [s_in, e_in, s_out, e_out] = adjust_image_size(dim_in, dim_out)

   if dim_in ~= dim_out

      %%%%%crop
      if dim_in>dim_out,
         s_in  = round((dim_in-dim_out)/2); e_in = s_in+dim_out-1;
         s_out = 1;                         e_out = dim_out;
      else
         s_in  = 1;                         e_in = dim_in;
         s_out = round((dim_out-dim_in)/2); e_out = s_out+dim_in-1;
      end;
   else
      s_in = 1;  e_in = dim_in;
      s_out = 1; e_out = dim_out;
   end;

