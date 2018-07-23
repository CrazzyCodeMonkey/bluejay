component output="false"{
	variables.version = "0.0.0";

	public string function getRoute(){
		return variables.route;
	}
	public string function getName(){
		return variables.name;
	}
	public string function getDescription(){
		return variables.description;
	}


	public string function getVersion(){
		return variables.version;
	}
	public numeric function getVMajor(){
		return fix(this.getVersion().split(".")[1]);
	}
	public numeric function getVMinor(){
		return fix(this.getVersion().split(".")[2]);
	}
	public numeric function getVPatch(){
		return fix(this.getVersion().split(".")[3]);
	}

}