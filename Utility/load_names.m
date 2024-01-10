
function names = load_names(name_input)

fid = fopen(name_input, 'rt');

index = 1;

while feof(fid)==0
   temps = fgets(fid);
   names{index} = deblank(temps);
   index = index + 1;
   clear temps;
end;

