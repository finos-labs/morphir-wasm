import {series, src, dest, TaskFunction} from 'gulp';
import esbuild from 'gulp-esbuild';
import ElmPlugin from 'esbuild-plugin-elm'

//declare function ElmPlugin(): any;

function build() { 
    return src("./src/Morphir/Engine.ts").pipe(esbuild({
        outfile: "Engine.js",
        bundle: true,
        loader: { ".ts": "ts" },
        plugins: [ElmPlugin()]
    })).pipe(dest("./src/generated/dist"));
}

export default series(build);