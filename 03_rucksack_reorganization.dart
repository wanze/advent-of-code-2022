
void main() {
  print('part1: ${part1()}');
  print('part2: ${part2()}');
}

int part1() {
  int prioritySum = 0;
  input().split('\n').forEach((line) {
    int compartmentSize = line.length ~/ 2;
    List<String> firstCompartment = line.substring(0, compartmentSize).split('');
    List<String> secondCompartment = line.substring(compartmentSize).split('');
    for (int i = 0; i < firstCompartment.length; i++) {
      final String item = firstCompartment[i];
      if (secondCompartment.contains(item)) {
        prioritySum += priority(item);
        break;
      }
    }
  });

  assert(prioritySum == 7811);

  return prioritySum;
}

int part2() {
  List<List<String>> groups = parseGroups();
  int prioritySum = 0;

  for (var group in groups) {
    group.sort((a, b) => a.length.compareTo(b.length));
    List<String> smallestRucksack = group[0].split('').toSet().toList()..sort();
    List<String> secondRucksack = group[1].split('')..sort();
    List<String> thirdRucksack = group[2].split('')..sort();
    for (int i = 0; i < smallestRucksack.length; i++) {
      final String item = smallestRucksack[i];
      if (secondRucksack.contains(item) && thirdRucksack.contains(item)) {
        prioritySum += priority(item);
        break;
      }
    }
  }

  assert(prioritySum == 2639);

  return prioritySum;
}

int priority(String item) {
  List<String> items = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
  int pos = items.indexOf(item.toLowerCase());
  bool isLowercase = item == item.toLowerCase();
  int prio = pos + 1;
  
  return isLowercase ? prio : prio + 26;
}

List<List<String>> parseGroups() {
  List<List<String>> groups = [];
  List<String> currentGroup = [];
  int index = 1;
  input().split('\n').forEach((line) {
    currentGroup.add(line);
    if (index % 3 == 0) {
      groups.add(currentGroup);
      currentGroup = [];
    }
    index++;
  });

  return groups;
}

String exampleInput() {
  return '''
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';
}

String input() {
  return '''
DMwrszrfMzSSCpLpfCCn
RMvhZhQqlvhMvRtbvbcPclPlncddppLTdppd
tVMQhFtjjWmsFJsmsW
trRtvNhfJhSzzSTFVhQQZQhHGphP
CnLMBWLwDMgMcwwdngdHGPVTQGpTHZdGPGpd
LLDqcDgwqCMnLWqtvzrzbbtJqPjJ
wQQwHNQLmbWQbQRHwHNFBbwqPfjqlzRMGRqzpSfvPlzplM
nCtGCZZtsGsrtDMZpfMpSlMlvlZq
cJctJCgVJsCJnDTsCthGhGLwBWBbbQmLbgQLQQdWbbbQ
ZWnNlTNTnhhQQlDNdmmpwrrrqBwjwjZd
GzvlVRSfvMVMvGlSpdCCdjmfpmBCdsqB
bzlFlLzJWLHHttLL
SmzFhVDzrmSrszVDVhSVbhZcCZdfZNcnMfMbZnNN
PTTRGqwqTqWRwLgTLTZGnCbZbNddZCCtMcNs
sgPqPqgJgWWqjjwgwLLVFBFSVmvmBBrmJJDSvp
CBccfSBhcSBddfgtlJmmmwmPRwmh
FpTzzGWHWprgDtJlDZDPFR
HbbTzWnTrnWtCbQBbQqQbSjf
fPHspCjgwZggSvZQ
RrNhzFZFcNzFLNLNwQlSlLnv
TRFrcDVrrRmrhFRZzVrczqhRpjqjsssCpfHjsCdpsPfpjCMC
ZBnBTMVTSbGbTVTGbCPgqsgPtHtgCcPtBB
ldDrmnnNrzhdhfgcsHqcsfCcsCHg
zFdrzNdzQNDDhFdWldDrJTbZTbLZJVVVpMVWVnLS
pLnpQNhBbnWvbsWm
FrFwjlTPTdTqqrDZWbvmZbpSgmJWvbgS
RqDqRrdGFpGRFrFFdTNzCcHcHLHBzQCcNNGN
bvRCtbtCPfSGtCcvCbPNlglqgqlGZMzTgnlZnq
hrmWWFspsHWrzNwTnFlTMTwFFn
HpjJDWBQmmQdRffbPtSzdJ
GpHjFsjMFpCpMWjMGCqWmmqrWQtmthdbDbbD
fzgLTJwJPSgJgzSzPfhmqmQhQHzQtbQDrrmq
RNlBRwHfRJHLLfHTwLSBppNGvjNMFFCVpVFcvcFC
SfQnfSFHfnvMtQQSnHJtMffsdTlZtdZmtllmTlmlRRbBRLDb
hrwhWWwqzPrcCzwwzmPlRbdmlQDTPPBLDl
CpwCzrwGzNCWrJnMvpMvfJVFvQ
rCRPpgSggcpqrhPrCDDTLsMLDSDGLTMGVs
HdvzmRWmlHzwvWHvRHRvHJbDFsdMssQQVGMDTMDLVLLFLT
JBlBnnWBJlCqZRRqRBpr
GtZllZDlfDpGHZtZBGBZpDmzQzzCSVVFHmmmsPCQWWSS
JvFJJrwvNNcJTnbrTRNRSCzqwSsVPCPQqmCQszVm
JLMnTbLnMgBhDFDf
lffDhtgDJzCJNGGTzWTRRnRvBv
qpbpdwqZwqZSwMPSqdQcQmTRnWvnBnRBQBtVnTvWmB
SccbbwSbZbFPswpSZtgFlClLhgChhhNfJlFj
ClmCjCJBjwBVwJGjlGNFJlVMHSrfpDpTfrHMcHTppQVrHp
dRLZWLvWSHmTccWW
ggtqzmRZnmhghZhZghntdqsvBbjlbNFFBPwNNJNNCBlwPGBz
HZmsFZQpvZsWCZQvWrghGrhtgNzdHddHGh
fWSbqWDJVwcSccNzrNhcBtGcgG
VqVfTJnbWjqTSqbwDRfRvQvFpFLRpZsssQsCQZ
FpFZNfplSTJmbZzddGzhDrWh
LqLPPQjLLRMPqvjLLHQrLqrRWdzHnGhdthttGGbbDWhDDdWz
sMLMgvRLgscrLrRQvwmTNNfpNplglplfmp
MPVBmCmWGWRPPqRhLcnjcvjjcpjMvp
tzwrwsJlrldJsrsrTtrzrTtSNnLJSShnjcncvnvqnSFnqN
rswrzsbdwDHHbWZqVfWV
dVmmMTmBPTrCBRMCqFHSWFFHWzCvCz
jNqfGsDqtsjGjQjDlcJFFFznFtzznvtFpFFp
fNNhgsDcfNflqchVRdgVrRPRdVTRRb
HJPLwgLvjttmgHJFjwHgtlsBbNbbNsPpblspTllThT
MzmcRRrdDMVTzbhNNSszhl
mCDDVqdVcdDrqfcCnrFwtGwvngwvtWJtFjWW
dFDpmttBlvNNgWlglNDBFttmTGHTcSSJJHHnMsJsGGSdqcJj
zLbwMLVQbQRwVsJsSHSsHcJqbj
wfVZLPzfZZmpMZZMBl
PZHZMJSTBWHNWSHzVnhhfnhThhpnpC
jFdBBtrFjpfnjfnf
ccGrbblbGRDQMlvmQBvmBl
PCCTsnbPbHDnlDfDNB
rMjQltgSqtvMjScQggjfVVzBzFHzGfVGDLGBqB
vdtrMSttcdwcpSQSdglMrtWRRPJZCpsRZJmWRRWChWPh
pWzbsPCCPPpbptSMCJJwBQQGQt
cDDmcTTRRqzFRddVTSJwMShMtBwhwQMDwv
HldqVmVlZdLTcmRFdrngNNzrffjWpPLggP
JPqvjJmmqvSLmPtpZdcftdmtfdCC
swwhDRwBBHjFFBtBfZ
RRzNQDwznDsDwWJjLNlrSPLSTr
VQmdRLvDlmqZdFrBBJdW
CMstGsnHnHGGMrMZwMpwBSbW
GnsshssNfjtsnggnHCGhjtmfLQQczllvDRVTTQllQWlQ
dhbNbswbwVdNtVdstBtgbNQTBCCSFTmfmMFmfRqQmmQM
HFljLrvZfMQQQPvm
WrpznLZZrnplpWbgdFcFsNzszgst
LjddfTlMccnBfDQBtBQb
ZRSNchHwhNNCHNSWPQFFFHDBBtnQDH
CNpZshSZgpwJmpdLMlplMc
bTmTFmqzgbBntRVsFvVwcv
CZfMrlZLLLMlfPZRLRHGstnjGwtvGcsSVwtcSGvn
ClZpMLCRMZMrHMLmWpqQBpzpgQzmbg
jDmSSGWDDdWdSqqDDqCqpJzqRRqpJnRsMRcMzM
lPgNPvPrrgNrPhNszFggnRzccbMJgz
ZQTHQvQTZPrrQlBBrNvQZZGtTtGdsVCGsCTLLGDmLsjt
rbCfBrbsvQqRFZRNZC
HLSTcwqwZSQFFgRZ
wdDwjpMHqJDTMTdqjlfBvGBhsbfhbsnb
ZhZcHHHlhgchHhlCZZhLCCbGdrsBBGPNBjGbsjNNjnJnPn
wtJqqwDqQQMQFqSqTzwzVTBnGdsjBdnMdPGBBsBdnrjr
RVzJzmSVZmLLWpCc
gdqjQQrlhhQlQrhsnjjhLgmmvmHBBmTmZRsHJzTBHRJv
NwNnGNbGPbmTGpJzppBG
nDnVDfMDrQqQStgM
MLbgbppMMgLmHgQttGQJgJrBShwNShWBBSNNrwNqNN
GnTFlzCVVwPRrVWhSw
GnDDdvdnZDTdnGMsHbbttZgttLbc
mdmPmjClrTzqttfm
cpFnSbcQQsqNNtqWJzHS
QFpcMMBcZtLpQBjVjZhlPjjVlwvw
spVsPjTZZMpZMVLDjmdSQJCLJSmLzdJQdl
HhRnNrqwMhNhnqnHwGNRFBNBrzSCSdQmQCdddbrQSSclSSbQ
nFNqGRvqBfjMvTssfZ
FjjzjnpFqqzFFqgFSZjBhHfHhnHRDDwfdTdLfD
MmCMGCsMWbtJrtCWCbmsmWWhdLGGwRBwdfdLhdTLhHHTBd
bJmtrRvRjgzFFvVq
RWwWmVQGMFGmMGVCVWRRZSBgDdSdJGlSJpcBGGSlpJ
HHhQThnjBDHfSBlS
bPhNjbsssQzFNQqWmz
FTDtrjqwwqGtDbGnfBlcnLcWBZwlWn
mMhRMvJsJvJnMHCvHmhLZLQlhWQBBfPfLPBZ
HRCCsdNdvNmCvggFStbzjbGSSjjn
sLGddsvvcZmLvrLMGcMsVnTTlqlHCsTHHVVgVt
wRbfJPbpNRffRJMBhpDntTCHFNVgqllFlqggHC
DpfbPhRDJPMJppJwzfpbbDGSjrGZvdccQdjGvQZdvrLz
wTwLNLVTqnLMsBwfMsJmCj
JhlGvcdJhSFvFvvvMfgBpCzjzdCfsMMs
DSlPPJSGWrDcFPhtFhWJZHQZLTQVnRWRbHbZHQQT
TmTgTrPDNLNVlDrmlbgNmrSSGbzjZGMvjpZjvvphWMzW
QtBfdfQcdfHtZcnZnGZzchnp
HQHwRBGfBCGBtsrCNPDTmTlNLr
bfNhjhNJDWhlWhlRRR
SsscnHgnSnZnltqqfWRWrzZv
cnfTMfmMnTnmFGsnTVLLLpQJbpbbjpdTdN
BqwZzqRQQRRPSlFRQDDwdfWwhJphnfgfnpMdJfdM
rcTLrcrvDDChWJhfpTgTJh
DHGbGNVCZStGqSqS
dlfdRNNfVdLwrRnwdwRmhLFsbsJJgLqbgCBWBCsW
PHDppMPMHHDPzmBBCmWJqCmbJD
HzzZHmZzQcNdRRdZwddr
wrlshslPsSRfvrQvwbrslCDghtDgCVhDhBVJCFHddt
mZnGpWpWzGTMqnFqDqJNDNFJVJqH
LjpzGcjMGcTzcmmznWSRsfRPfcrbFQcfrwcv
rWBmmmtNmmtBbtlwnhJJVZbw
FsRcjGdLdvFslZbQJZwQps
GHFGvMccFPjgDNbmWWBTTHNz
GhHzmhmwlpbltGBmBmsZsBZsfCWC
rgrcCCPdsWBgNVBD
RnRMdQPMCqndSdQdcQhblpLLwhJbbpzGzwpS
NNQtStFPpJwhRbRzRbqpZZ
jLnmdJrrdDTdbgWbTbRW
JHvnMCmDnMnMljLCDmMLjHNFGGNBPVtQQFtSNFQtPQBv
BFbBRllFZJnPVJbV
GpGHwgzcLhDcwttwthzzhHcPTjZjMgMVZjgZTMmTnMZWJVJm
GccwhqcDtlrPqQrRNQ
gWHWLgHBHQdFhjGGThTQhR
pZsSMpZMJJSzMszzzqclpfjvrvvcRGGTcTVhbVvRbTGTRG
lnMwsqZqsslpjlSMSsffZqqJBgHNNPNDWdLLgdDgdLHPWwCw
qfNvBCBfBqfNMBqCZZfcnmnvtwScpwFSpSsSwt
HzdVzLWPPGGDdnsswnztsRsnmn
QddWVQgJPPHJTJbjBtNTTq
DdRDDPRGGPGccfcbJwsbJWzsnznlLLWzWTLWhVVVVS
CvCrNCqgFqvmqNZFZqqZvpWlVrlVhlhnTLShlDWnzVBD
jvqpvpvpQNCQQCZZmmNgZfdGddRjJDPRMHcHJDHPJf
ttdtBtPPMqWMdgPPBbVGWfTGTTzSVLfVrzCS
ZpDpvRpZDDcmmjmZfLSrwzRnSVSnwTTR
ZvQmjFVHJFDcQjDlZcDVHdqMNtqNBPtPJtbhhbdbts
dGdwwLLpgwgssJpgssNhpJlnbfjnzFfcbfttGjzjlntf
VQvDvHVVQHrQHDCZVBChrHFtzffnfltFFtncnvFtllMl
VBShSqDVRVSTmppPwwsP
fTFDTLNNzlcNrmDcrMDTFPwCSsbCbPPsnCPwLSPvbs
ttQqhJtBRRGnvgHGnlSnbl
hZBJlQBRjVRBRjhtRRMNFVmFmfDNrfWcFVmD
mcTZFBFmqBjmBgPtCtPprmssStCP
LWDQNqDJfQNJddnWfzhfsPRVppVVsSptftpVMS
NDGnJDDDbzddWdNbGNQQLQbqqFBBFcjlZBlHjlZHGBTvZB
PwDzvphPwVwWBqLLwnJWTq
jdCGCgjmllCrmmlmjrbgmRdgJSSJJFLSSqJfLnqLLLbWffLB
mRdjcMHgDpZhDqMZ
cqLjhhrwZwJbBqZhMwbZZdGWdGSllWFvLFGQdnGFQG
gHHVzzppRVggcgpcGWRQRSvdSvvGWvll
HmNNHtVggHsHPtrhJsbjbwCrCqJc
zqPvzLVvzFFQZzWpRLlmHRDHmRCHDH
dNjnJGGrGdqqMprRlpqB
GsgtjhSsSvvSFqvP
pVrfzzjrjWVWTWjrNZvnJSJZqnnqnpSZZS
bdQVQPRPDdcbRGPFddRVMVlZlMlBqSBBZSvSZwnwvJBS
bFbcFbCPPCbbVHCCdVgWfrzjmWfrWrNWgHfT
JgJqLjjjVGgdqGDZGzlGRStStT
PHrHccmrMrTSMVStRtRR
HWPWffNsrppfPWNsVFsmPNCJwwjdJdvdvnJwghBLJLpdLJ
HtHvcnDSDgDcDHtpLrvwjwjfZMjffw
CPWzdJdqVdWZpnLdwnrfdn
GNCNmTQnPVRRglSlHsSG
FJdhjTPbdPJjTPjTjPtSLsSBWWRcCvCvsBWztc
MfGgrHMDDpMnZGDLCRLScCsBlgWvzB
HnmpmNNHGZZpZZrnMPFFbNCNbFdTPVFFFN
TJrrrJQTqJqmTltfRrgfgtgFFg
jLRzBvBjjcnFBNwWlgBZFt
RMjMCGpGzGznzhRmmPPDPsmMmPQmJs
BZqwQCQZGZcVBczqBHtfbbbWfTqNWfMfPNqW
LLpmFjpvpHrvRFSRDRMWbdbtfPWPbjtMgMtW
SDnrpDprDFnQhZCVnhcH
WTsBBQTfQQTTbJBbZbnfTsRFwFrjwjFlrRqvrrlqvWRV
pGcShcGSLNJNHCLttlpllRFgpRFlRpgRrg
GzcMLScSGJGtCbsbQfbZbMBnBn
NGCLGjVjZjQwTGJRQdWM
cFTcvSrFmnnpSmndMswsRMJWRwMHps
rrrhhcTznqvzmcccvvmhgzqDgbgttlDtjjjlfVCfZCjZZV
ccDMHddWNDnnNWMMzdHJJmSQhfQZfvQZflrZQfdVfLLZ
bgBFRTwFtgqCgpRGFpvpVllZlhjrrlVlvj
wtbBGPTPtRTgbCTBqFgGRwFnsWJnmDMsWMJJMzHPhDmJzP
zsbsMtMMdnffBbzNsBtCCWLpLrCrcNLVDWVVcD
TmPhJRvwmjmhFJwjjRPFPTvJGVCcCGBrDpccpDrCrWCVDVFZ
QvSTvBhqwjPmwddHgtqMnllzMl
gftDtqnpqzGZsFcthbtZ
VlNPrBrRNrLBmdRVFCcGCZTFCsTCsbLL
VdldlljlSNHBsSlqfgqMDDvzpHJHWg
tQDLvFLcDrWrcnsHffCGgGHG
ZRPTPJqhMZJZVllRZJPVZPRHnhCnfdssnCznzGhdgfwCHn
qPqlPVlTlSqbZZVJplqlPDmrjWFtmLtFWgQvtmtFvp
zlZzdNRPgGGzsLGCDBBtCDCtSncScP
vWvHWbqjrFMbvrTWcVnQBBBSjLDcQJcL
wfLHwfFqLFbhHvWhMWqwbwwRspssmzgpzGgmmNfmzmRGRz
rPvLrQBvBLsLLdtrgssgZjwFwlnCFMtMFnlllnnb
mNmmzpWHlzjlJMJb
TVSVTWpqRWpSTqNbTVRBPDfLLPrSLrsfQrrvsf
nRjpQWnQnRQzMjRdrtvvPCfmvGtPfMcCtG
TDbrbhNZVbbbbwhDZDhbTTGfcftqcGVvmmcqcJCcCPmJ
NLhrSwgwgnsLsQWljW
JWqVSpGNPdNNzdZJJpMzHzwLgsMwzwQwMBgL
clrlcvrRfccCtFbHrBWLgwLHmMHsHg
DbfDFjcvRcvchWZVWdNpGZNqdh
sdfvFLfmtszQwLfddRpmtDDBjVNWGMNQVQNMJGWJMj
lccrncTZhqqcqhWggvrjMNMGrJMG
SblShnZCqSbPhhbcbTTSZFdFsFpmdRwPwzvmswLtmm
PGwwHpfnFSvVpWqWCQNNjCbbnW
lmddlhcDRBlLRchdmzbNjqqWTcbNPNWTzz
RBMrRdRhlDtPrJtfwFHpsvrHpFSrFw
hhwlglFFSQndLRFbmCbTTz
NczHMMqzpzPcpfBffcmTrdfGbbRbGrdGrLCL
qNzNPqMjcqNBWWccBHsZPDhJnllwnwvJvQnJhQsgvD
mbmvmvbbprZmlFmZbFgLffgQtFNHNhfqQtNQ
SJcdzjSJBzdBdJDzQhhLQfqzNQQHggRL
jwDwcTTDThvTZPPW
FSVBBBvHvCpVVDDGcGwNNhhctwMvMc
fLLZsZVQmjfTfqQRmQhhtgbbJbGJRghtcGct
qTsTQdqjVfqdVdZZqVLpCpzSpdppBlSpCFdHSC
sQQhWsMmQshlhmMQZFDHDJFjgjzHZgcHdH
LnwnpNRrnrbCqqLpwnqfnLcvFHJFzNcHzJcgJJHgdDgN
wCbnpCfPCVqwwnrrbbPRGMMlSllmlTTmsThVMlsd
pzrprfwgbwtwqzrCWbqCwqSMvddHdDSvtHRlDnRRDddD
zQLzQQjPBPFcLcQFTFsmNQzcMNdDdvnldHHvdvnDnRnlvRnJ
cTZGzzscLcPrqrfrZqqbVV
DcSdcTwDLmcwDwvWssGfJfcJQZPGnfcs
FlHFMgtgNggpsztMHMqpjgBBnCfPflfQnZCQBBCnRPZC
gpVjqNVrHFtjqqzSLDTSmTDwwrmhbs
MLMzJTsZzZMgMLgHMmVmdCVhCBlQwDwwhChD
vtPRQpbqCldwdtBC
bQqFbnQbcFfjPRFPQnTrMMgcJgJrssrzgrgS
mtdGJmQRFmdtQvdvtRtdHzHzqZqpHFzZnCzhZjjH
fPwVlllswMVNPfBDDlNVsMsfcBjchHncqzjZbpzjcqCnpHHn
rlsNPWNlhWTPMMNPfwNWTLQRvQLLmgvSJvRJgTRG
TwnqhqqgvQnGBGmBDp
SMjclJSjjVJgCzCzNgpmdBpmBGspRBmpDDVB
JjMCgMMHMMZNStllZSNHhPqFhFWfqPPqTqhLFqtL
lRQPtjPRlDdStDSlPmvllvLsCphFfCHLHggspgFmsFLH
qwpTNprcbNWVHLrfFssBgFCM
NTWTnzTTWGZZZVRSRRQGpdDtSQRp
gpwTPNPBPTdLLLLVGl
jSHdjzZHMcDVtDvFjtCF
HqfZMHzbcqRRRWgdqPmBBBNmwW
PvSBtdFgvSmBPngFBTBjbSjwwpGjsppMjNpMjj
VZLfVQLzQQQhllpcNcwbssvwwwZj
vHWLVVqWTmTgttgq
CNRmNRFNRCWbWNCrlmfGlWqFLsDZQZBZzgwQZsBsDZZCzczB
MSjdVHvHnDDhHvdwBwssZVzwcgLcQg
HnMMTdttHSHSpHvDddpSHTjWlNWFlmRtRmRbqGfqGGNNfR
fBLTDppznrfTndfnfTzTLPvZvvHVbRbggjvzVbzvbV
mwmDGGlqDhMqthGqhJMWmlNVRZPHjgwjjRZbbHRgRHvv
DmhsJsshWGhSGlmlmrdcLLsTBBfcfnBppc
mbCGFFmGmcdTrCTQdh
MJHfJNLllJffPLRTdBqTRQNcqQGB
fPJHfSSSWfSLDMLWGHDMLDFmznmsjmvZwzvjZjbvbZ
pPvpJSfZTTvCzNZczzQZchcj
svbHWsqsvbsMFtVHgVtcRQcDlQRRRQLjlqjczj
tBsgvHVMFggbgFrgWnwSndfBmmBJfPSfpn
jwbwfjSbwjVSjvZPzWSvhvhQlCsBFgLRLLgBLRClLLFQQw
GdNJHpmHTDnTNJqnFCgBLFLFzFtsQRCd
NpMJHpnMrDpJGTHqTTmJHTPjfcvbWfrffVzvZfVWSbjz
wFwpqWwwpqwtqqrbCFtptDmCcfNhNRzRBZRRJRChVNBZBJ
svlvjHsQlvdlvMLdlvPSSLtzzczcNhJthfNtRcNMJNMc
HvvPLSHjgltjsvqwbbnmWmDpgwTT
zhCmPVwwChdCBtsWnNWswBWr
GJJSfSgFpjJjGgpfpgrcNNstvnBHNnHLtFHr
jgDTfjpMgZMGMGJTMMJRhzZPCzbhVlPqdNCbhd
bDbQQmVDRpDNbRQlfQQZnfwTlllfsT
FChzzBWhVzrgMwffJwlnngnTlJ
MCvqvhFzcHCChjtpNNVLppGmbq
bZZzJnccqdzcLhrcQDLrDs
FfCfWVfjWTFClClfwjWCfGGwhZSDhSLsSSRpZprLph
mFmTMmFjMMWFfZtttflWjmWTngNHJHggJJHtzgnJvBtBgHdv''';
}