import * as Plurals from "make-plural/plurals";
import Mustache from "mustache";
import type {
	CatalogKey,
	NestedCatalogKey,
	PluralTranslation,
	ReplacementValues,
	TranslationObject,
	i18nCatalog,
	i18nOptions,
} from "~/locale/common/types";
import { createLog } from "~/logger/common/createLog";

export class i18nProvider<T extends i18nCatalog> {
	private locale: CatalogKey<T>;
	private readonly catalog: T;
	private readonly localeList: Array<CatalogKey<T>>;

	constructor({ defaultLocale, catalog }: i18nOptions<T>) {
		this.locale = defaultLocale;
		this.catalog = catalog;
		this.localeList = Object.keys(catalog) as Array<CatalogKey<T>>;
	}

	getCurrentLocale(): CatalogKey<T> {
		return this.locale;
	}

	getAvailableLocales(): Array<CatalogKey<T>> {
		return this.localeList;
	}

	setLocale(locale: CatalogKey<T>): void {
		if (this.localeList.includes(locale)) {
			this.locale = locale;
		}
	}

	getCatalog(): i18nCatalog {
		return this.catalog;
	}

	getTranslationObject(locale: CatalogKey<T>): TranslationObject {
		return this.catalog[locale] ?? {};
	}

	private _translate(
		locale: CatalogKey<T>,
		phrase: NestedCatalogKey<T, "singular">,
		replacements?: ReplacementValues,
	): string {
		if (
			!this.catalog[locale] ||
			typeof this.catalog[locale][phrase] !== "string"
		) {
			createLog("Locale", "warn", "Locale phrase incorrectly configured");
			console.log({ phrase, targetLocale: locale });

			return phrase as string;
		}

		if (replacements) {
			return Mustache.render(
				this.catalog[locale][phrase] as string,
				replacements,
			);
		}

		return this.catalog[locale][phrase] as string;
	}

	private _translatePlural(
		locale: CatalogKey<T>,
		phrase: NestedCatalogKey<T, "plural">,
		count: number,
		replacements?: ReplacementValues,
	): string {
		if (
			!this.catalog[locale] ||
			typeof this.catalog[locale][phrase] !== "object"
		) {
			createLog("Locale", "warn", "Locale phrase incorrectly configured");
			console.log({ phrase, targetLocale: locale });

			return phrase as string;
		}

		if (!Plurals[locale as keyof typeof Plurals]) {
			createLog(
				"Locale",
				"warn",
				"Plural data does not exist for target locale",
			);
			console.log({ phrase, targetLocale: locale });

			return phrase as string;
		}

		const phraseData = this.catalog[locale][phrase] as PluralTranslation;
		const pluralTarget = Plurals[locale as keyof typeof Plurals](count);

		const targetPhrase =
			(phraseData[pluralTarget] !== undefined
				? phraseData[pluralTarget]
				: phraseData.other) ?? "???";

		if (replacements) {
			return Mustache.render(targetPhrase, replacements);
		}

		return targetPhrase;
	}

	translate(
		phrase: NestedCatalogKey<T, "singular">,
		replacements?: ReplacementValues,
	): string {
		return this._translate(this.locale, phrase, replacements);
	}

	translateToLocale(
		locale: CatalogKey<T>,
		phrase: NestedCatalogKey<T, "singular">,
		replacements?: ReplacementValues,
	): string {
		return this._translate(locale, phrase, replacements);
	}

	translatePlural(
		phrase: NestedCatalogKey<T, "plural">,
		count: number,
		replacements?: ReplacementValues,
	): string {
		return this._translatePlural(this.locale, phrase, count, replacements);
	}

	translatePluralToLocale(
		locale: CatalogKey<T>,
		phrase: NestedCatalogKey<T, "plural">,
		count: number,
		replacements?: ReplacementValues,
	): string {
		return this._translatePlural(locale, phrase, count, replacements);
	}

	getTranslationsForPhrase(
		phrase: NestedCatalogKey<T, "singular">,
	): Array<string> {
		const translations: Array<string> = [];

		for (const tObj of Object.values(this.catalog)) {
			if (typeof tObj[phrase as keyof typeof tObj] === "string") {
				translations.push(tObj[phrase] as string);
			}
		}

		return translations;
	}

	getHashedTranslationsForPhrase(
		phrase: NestedCatalogKey<T, "singular">,
	): Array<{ [K in keyof T]?: string }> {
		const translations: Array<{ [K in keyof T]?: string }> = [];

		for (const [locale, tObj] of Object.entries(this.catalog)) {
			if (typeof tObj[phrase as keyof typeof tObj] === "string") {
				translations.push({
					[locale]: tObj[phrase] as string,
				} as { [K in keyof T]?: string });
			}
		}

		return translations;
	}
}
