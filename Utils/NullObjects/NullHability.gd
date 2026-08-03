class_name NullHability extends Hability

func execute() -> HabilityResponse:
	var response: HabilityResponse = HabilityResponse.new()
	response.status = Response.FAILED
	return response
