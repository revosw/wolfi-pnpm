FROM chainguard/node:latest-dev
WORKDIR /app
RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . ./
RUN npm run build

FROM chainguard/node:latest
WORKDIR /app
COPY --from=0 /app/build /app/node_modules /app/
CMD ["npm", "run", "start"]