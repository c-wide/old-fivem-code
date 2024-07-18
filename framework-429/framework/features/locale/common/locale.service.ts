import { Service } from "~/decorators/common/service";
import { catalog } from "~/locale/common/catalog";
import { i18nProvider } from "~/locale/common/provider";
import type {
	CatalogKey,
	NestedCatalogKey,
	ReplacementValues,
	TranslationObject,
	i18nCatalog,
} from "~/locale/common/types";
import { config } from "~/utils/common/config";

@Service("Locale")
export class LocaleService {
	private readonly provider = new i18nProvider({
		defaultLocale: config.server.locale,
		catalog,
	});

	getCurrentLocale(): CatalogKey<typeof catalog> {
		return this.provider.getCurrentLocale();
	}

	getAvailableLocales(): Array<CatalogKey<typeof catalog>> {
		return this.provider.getAvailableLocales();
	}

	setLocale(locale: CatalogKey<typeof catalog>): void {
		this.provider.setLocale(locale);
	}

	getCatalog(): i18nCatalog {
		return this.provider.getCatalog();
	}

	getTranslationObject(locale: CatalogKey<typeof catalog>): TranslationObject {
		return this.provider.getTranslationObject(locale);
	}

	translate(
		phrase: NestedCatalogKey<typeof catalog, "singular">,
		replacements?: ReplacementValues,
	): string {
		return this.provider.translate(phrase, replacements);
	}

	translateToLocale(
		locale: CatalogKey<typeof catalog>,
		phrase: NestedCatalogKey<typeof catalog, "singular">,
		replacements?: ReplacementValues,
	): string {
		return this.provider.translateToLocale(locale, phrase, replacements);
	}

	translatePlural(
		phrase: NestedCatalogKey<typeof catalog, "plural">,
		count: number,
		replacements?: ReplacementValues,
	): string {
		return this.provider.translatePlural(phrase, count, replacements);
	}

	translatePluralToLocale(
		locale: CatalogKey<typeof catalog>,
		phrase: NestedCatalogKey<typeof catalog, "plural">,
		count: number,
		replacements?: ReplacementValues,
	): string {
		return this.provider.translatePluralToLocale(
			locale,
			phrase,
			count,
			replacements,
		);
	}

	getTranslationsForPhrase(
		phrase: NestedCatalogKey<typeof catalog, "singular">,
	): Array<string> {
		return this.provider.getTranslationsForPhrase(phrase);
	}

	getHashedTranslationsForPhrase(
		phrase: NestedCatalogKey<typeof catalog, "singular">,
	): Array<{ [K in keyof typeof catalog]?: string }> {
		return this.provider.getHashedTranslationsForPhrase(phrase);
	}
}
