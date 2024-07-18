const { esbuildDecorators } = require("esbuild-decorators");
const { context } = require("esbuild");
const handleBuild = require("./handleBuild");
const nodePaths = require("./nodePaths");
const dotenv = require("dotenv");

dotenv.config();

const define = {};
for (const k in process.env) {
	// Bypass windows errors
	if (k === "CommonProgramFiles(x86)" || k === "ProgramFiles(x86)") {
		continue;
	}
	define[`process.env.${k}`] = JSON.stringify(process.env[k]);
}

const isWatchEnabled =
	process.argv.findIndex((arg) => arg === "--watch") !== -1;

const shouldRestart =
	process.argv.findIndex((arg) => arg === "--restart") !== -1;

const buildConfig = {
	server: {
		platform: "node",
		target: ["node16"],
		format: "cjs",
	},
	client: {
		platform: "browser",
		target: ["chrome97"],
		format: "iife",
	},
};

async function build() {
	for (const [targetProject, projectConfig] of Object.entries(buildConfig)) {
		const ctx = await context({
			bundle: true,
			entryPoints: [`features/boot/${targetProject}/bootstrap.ts`],
			outfile: `dist/${targetProject}.js`,
			minify: targetProject === "client",
			plugins: [
				esbuildDecorators({
					tsconfig: `tsconfig.${targetProject}.json`,
				}),
				handleBuild(targetProject, shouldRestart),
				nodePaths,
			],
			...projectConfig,
			...(targetProject === "server" ? { define } : {}),
		});

		if (isWatchEnabled) {
			await ctx.watch();
		} else {
			await ctx.rebuild();
			await ctx.dispose();
		}
	}
}

build();
