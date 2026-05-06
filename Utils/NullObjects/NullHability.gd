class_name NullHability extends Hability

func execute(character: Character, delta: float) -> HabilityResponse:
	var response: HabilityResponse = HabilityResponse.new()
	response.status = Response.FAILED
	return response
