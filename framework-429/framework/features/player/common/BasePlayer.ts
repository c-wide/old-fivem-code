export type BasePlayerProps = {
	id: string;
	source: string;
	name: string;
};

export abstract class BasePlayer {
	protected readonly id: string;
	private source: string;
	private name: string;

	constructor({ id, source, name }: BasePlayerProps) {
		this.id = id;
		this.source = source;
		this.name = name;
	}

	getId(): string {
		return this.id;
	}

	getSource(): string {
		return this.source;
	}

	unsafeSetSource(source: string): void {
		this.source = source;
	}

	getName(): string {
		return this.name;
	}

	unsafeSetName(name: string): void {
		this.name = name;
	}
}
