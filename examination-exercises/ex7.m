% exercise 7
close all;
X1 = [191 223 242 248 266 274 272 279 286 287 286;
  64  72  81  66  92 114 126 123 134 148 140;
  206 172 214 239 265 265 262 274 258 288 289;
  155 171 191 203 219 237 237 220 252 260 245;
  85 138 204 213 224 247 246 259 255 374 284;
  15  22  24  24  38  41  46  62  62  79  74];

X2 = [53  53 102 104 105 125 122 150  93 127 132;
  33  45  50  54  44  47  45  61  50  60  52;
  16  47  45  34  37  61  51  28  43  40  45;
  121 167 188 209 224 229 230 269 264 249 268;
  179 193 206 210 221 234 224 255 246 225 229;
  114  91 154 152 155 174 196 207 208 229 173;
  92 115 133 136 148 159 146 180 148 168 169;
  84  32  97  86  47  87 103 124 110 162 187;
  30  38  37  40  48  61  64  65  83  91  90;
  51  66 131 148 181 172 195 170 158 203 215;
  188 210 221 251 256 268 260 281 286 290 296;
  137 167 172 212 168 213 190 196 211 213 224;
  108  23  18  30  29  40  57  37  47  56  55;
  205 234 260 269 274 282 282 290 298 304 308];

X3 = [181 206 199 237 219 237 232 251 247 254 250;
  178 208 222 237 255 253 254 276 254 267 275;
  190 224 224 261 249 291 293 294 295 299 305;
  127 119 149 196 203 211 207 241 220 188 219;
  94 144 169 164 182 189 188 164 181 142 152;
  148 170 202 181 184 186 207 184 195 168 163;
  99  93 122 145 130 167 153 165 144 156 167;
  207 237 243 281 273 281 279 294 307 305 305;
  188 208 235 249 265 271 263 272 285 283 290;
  140 187 199 205 231 227 228 246 245 263 262;
  109  95 102  96 135 335 111 146 131 162 171;
  69  46  67  28  43  55  55  77  73  76  76;
  69  95 137  99  95 108 129 134 133 131  91;
  51  59  76 101  72  72 107  91 128 120 133;
  156 186 198 201 205 210 217 217 219 223 229];

X4 = [201 202 229 232 224 237 217 268 244 275 246;
  113 126 159 157 137 160 162 171 167 165 185;
  86  54  75  75  71 130 157 142 173 174 156;
  115 158 168 175 188 164 184 195 194 206 212;
  183 175 217 235 241 251 229 241 233 233 275;
  131 147 183 181 206 215 197 207 226 244 240;
  71 105 107  92 101 103  78  87  57  70  71;
  172 213 263 260 276 273 267 286 283 290 298;
  224 258 248 257 257 267 260 279 299 289 300;
  246 257 269 280 289 291 306 301 295 312 311];

disp('(a)');
% % without any structure for the mean, can an intraclass corealtio model be
% assumed between the ten days? Test at level 5%

% plot all data points
data = {X1, X2, X3, X4};
hold on
for i = 1:4
  plot(0:size(X1,2)-1,mean(data{i},1));
end
legend('Control','25-50r', '75-100r', '125-150r', 'Location','southeast')
xlabel Days
ylabel Score


% calculate the correlation matrix in the columnn direcetion 
% (i.e. over time)
ngroups = 4;
timeCorr = cell(4,1);
for i = 1:ngroups
  timeCorr{i} = corr(data{i}');
  timeCorr{i}
end
% the correlation are quite high, which suggest intraclass correlation over
% time

