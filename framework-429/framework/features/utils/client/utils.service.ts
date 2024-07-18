import { Service } from "~/decorators/client/Service";
import { emitNetPromise } from "~/utils/client/emitNetPromise";

@Service("ClientUtils")
export class ClientUtilsService {
	emitNetPromise = emitNetPromise;
}
