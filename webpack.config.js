const path = require('path');
const glob = require('glob');
const webpack = require('webpack');
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
      filename: '[name].js',
      path: path.resolve(__dirname, 'public')
    },
    plugins: [
      new VueLoaderPlugin(),
      new MiniCssExtractPlugin({
        filename: 'stylesheets/[name].css'
      }),
      new ManifestPlugin({
        writeToFileEmit: true
      })
    ],
    module: {
      rules: [
        {
          test: /\.ts$/,
          exclude: /node_modules/,
          use: 'ts-loader'
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
                publicPath: path.resolve(__dirname, 'public/assets/stylesheets')
              }
            },
            'css-loader',
            'sass-loader'
          ]
        },
        {
          test: /\.(jpg|png|gif)$/,
          loader: 'file-loader',
          options: {
            name: '[name].[ext]',
            outputPath: path => {
              return 'images/' + path
            }
          }
        }
      ]
    },
    resolve: {
      // import 文で .tsファイルを解決するため
      extensions: ['.js', '.ts'],
      // Webpack で利用するときの設定
      alias: {
        vue: 'vue/dist/vue.js'
      }
    },
    optimization: {
      splitChunks: {
        cacheGroups: {
          vendor: {
            test: /.(c|sa)ss/,
            name: 'style',
            chunks: 'all',
            enforce: true
          }
        }
      }
    }
  }
};