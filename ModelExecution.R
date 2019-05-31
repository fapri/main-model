# Main Script Execution
# Corn and Soybean Model

getCropType = function(){
  type = readline(prompt = "Enter crop type (soybean or corn. Anything else to quit): ")
  type = tolower(type)
  
  if(type != "soybean" && type != "corn"){
    type = "quit"
  }
  return(type)
}

type = getCropType()

if(type == "soybean"){

}

if(type == "corn"){

}