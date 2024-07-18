import { Service } from "~/decorators/common/service";

@Service("CommonUtils")
export class CommonUtilsService {
	delay(ms: number): Promise<void> {
		return new Promise((res) => setTimeout(res, ms));
	}

	setImmediateInterval(cb: () => void, ms: number) {
		cb();
		return setInterval(cb, ms);
	}

	getOrdinalSuffix(n: number): string {
		const lastDigit = n % 10;

		if (lastDigit === 1 && n !== 11) {
			return "st";
		}

		if (lastDigit === 2 && n !== 12) {
			return "nd";
		}

		if (lastDigit === 3 && n !== 13) {
			return "rd";
		}

		return "th";
	}
}
