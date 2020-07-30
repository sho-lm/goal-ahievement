const path = require('path');
// const glob = require('glob');
// const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

// webpack の実行設定
module.exports = (env, argv) => {
  const IS_DEV = argv.mode === 'development'

  return {
    // 開発環境ならソースマップを使う
    devtool: IS_DEV ? 'source-map' : 'none',
    // バンドル対象のファイル
    entry: './frontend/main.ts',
    // バンドル後の出力先
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'public/assets')
    },
    plugins: [
      new MiniCssExtractPlugin({
        filename: 'style.css'
      }),
      new VueLoaderPlugin(),
      new ManifestPlugin({
        writeToFileEmit: true
      })
    ],
    module: {
      rules: [
        // {
        //   test: /\.js$/,
        //   exclude: /node_modules/,
        //   use: 'babel-loader'
        // },
        {
          test: /\.ts$/,
          use: [
            {
              loader: 'ts-loader',
              options: {
                  appendTsSuffixTo: [/\.vue$/]
              }
            }
          ]
        },
        {
          test: /\.vue$/,
          use: 'vue-loader'
        },
        {
          test: /\.pug/,
          use: 'pug-plain-loader'
        },
        {
          test: /\.(c|sc)ss$/,
          use: [
            {
              loader: MiniCssExtractPlugin.loader,
              options: {
                publicPath: path.resolve(__dirname, 'public/assets')
              }
            },
            'css-loader',
            'sass-loader'
          ]
        },
        {
          test: /\.(otf|eot|svg|ttf|woff|woff2)(\?.+)?$/,
          loader: 'url-loader'
        },
        // {
        //   test: /\.(jpg|png|gif)$/,
        //   loader: 'file-loader',
        //   options: {
        //     name: '[name].[ext]',
        //     outputPath: path => {
        //       return 'images/' + path
        //     }
        //   }
        // }
      ]
    },
    resolve: {
      // import 文で拡張子を省略できる
      extensions: ['.js', '.ts', '.vue', '.css', '.scss'],
      // import Vue from 'vue' での vue が表すファイルパス
      alias: {
        'vue$': 'vue/dist/vue.esm.js'
      }
    },
    // optimization: {
    //   splitChunks: {
    //     cacheGroups: {
    //       vendor: {
    //         test: /.(c|sa)ss/,
    //         name: 'style',
    //         chunks: 'all',
    //         enforce: true
    //       }
    //     }
    //   }
    // }
  }
};